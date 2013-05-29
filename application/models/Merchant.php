<?php

/**
 * Model for merchants
 */
class Merchant extends BaseEntity  {
	
	public function setTableDefinition() {
		parent::setTableDefinition();
		$this->setTableName('merchant');
		
		$this->hasColumn('type', 'integer', null, array( 'notnull' => true, 'notblank' => true, 'default' => '1'));
		$this->hasColumn('category', 'integer', null, array( 'notnull' => true, 'notblank' => true));
		$this->hasColumn('firstname', 'string', 255);
		$this->hasColumn('lastname', 'string', 255);
		$this->hasColumn('orgname', 'string', 255);
		$this->hasColumn('contactperson', 'string', 255);
		$this->hasColumn('email', 'string', 50, array('notnull' => true, 'notblank' => true));
		$this->hasColumn('phone', 'string', 15, array('notnull' => true, 'notblank' => true));
		$this->hasColumn('phone2', 'string', 15);
		$this->hasColumn('status', 'integer', null, array('default' => '0')); # 0=Created, 1=Approved, 2=Rejected
		$this->hasColumn('dateapproved', 'date');
		$this->hasColumn('approvedbyid', 'integer', null);
		# override the not null and not blank properties for the createdby column in the BaseEntity
		$this->hasColumn('createdby', 'integer', 11);
	}
	# custom fieldds
	protected $createuser;
	protected $createuserandinvite;
	#
	function getcreateuser(){
		return $this->createuser; 
	}
	# 
	function setcreateuser($createuser) {
		$this->createuser = $createuser;
	}
#
	function getcreateuserandinvite(){
		return $this->createuserandinvite; 
	}
	# 
	function setcreateuserandinvite($createuserandinvite) {
		$this->createuserandinvite = $createuserandinvite;
	}
	/**
	 * Contructor method for custom functionality - add the fields to be marked as dates
	 */
	public function construct() {
		parent::construct();
		
		$this->addDateFields(array('dateapproved'));
		// set the custom error messages
		$this->addCustomErrorMessages(array(
										"category.notblank" => $this->translate->_("merchant_type_error"),
										"type.notblank" => $this->translate->_("merchant_type_error"),
										"phone.notblank" => $this->translate->_("merchant_phone_error"),
										"email.notblank" => $this->translate->_("merchant_email_error")
       	       						));     
	}
	/*
	 * Relationships for the model
	 */
	public function setUp() {
		parent::setUp(); 
		$this->hasOne('UserAccount as creator', 
								array(
									'local' => 'createdby',
									'foreign' => 'id'
								)
						);
		$this->hasOne('UserAccount as approver', 
								array(
									'local' => 'approvedbyid',
									'foreign' => 'id'
								)
						);
		$this->hasMany('Store as stores',
						 array(
								'local' => 'id',
								'foreign' => 'merchantid'
							)
					);
		$this->hasMany('UserAccount as admins',
						 array(
								'local' => 'id',
								'foreign' => 'merchantid'
							)
					);
	}
	/**
	 * Custom model validation
	 */
	function validate() {
		# execute the column validation 
		parent::validate();
		// debugMessage($this->toArray(true));
		if($this->usernameExists()){
			$this->getErrorStack()->add("username.unique", sprintf($this->translate->_("useraccount_username_unique_error"), $this->getStore()->getUsername()));
		}
		/*if($this->emailExists()){
			$this->getErrorStack()->add("email.unique", sprintf($this->translate->_("useraccount_email_unique_error"), $this->getEmail()));
		}*/
	}
	/*
	 * Pre process model data
	 */
	function processPost($formvalues) {
		$session = SessionWrapper::getInstance(); 
		
		// trim spaces from the name field
		if(isArrayKeyAnEmptyString('type', $formvalues)){
			unset($formvalues['type']); 
		}
		if(isArrayKeyAnEmptyString('approvedbyid', $formvalues)){
			unset($formvalues['approvedbyid']); 
		}
		if(isArrayKeyAnEmptyString('status', $formvalues)){
			unset($formvalues['status']);
		}
		if(isArrayKeyAnEmptyString('dateapproval', $formvalues)){
			unset($formvalues['dateapproval']); 
		}
		if(!isArrayKeyAnEmptyString('phone', $formvalues)){
			$formvalues['phone'] = str_pad(ltrim($formvalues['phone'], '0'), 12, COUNTRY_CODE_UG, STR_PAD_LEFT); 
		}
		
		$thestore = array(); 
		if(!isArrayKeyAnEmptyString('createdby', $formvalues)){
			$thestore[0]['createdby'] = $formvalues['createdby'];
		}
		if(!isArrayKeyAnEmptyString('id', $formvalues)){
			$thestore[0]['merchantid'] = $formvalues['id'];
		}
		$thestore[0]['name'] = $formvalues['storename'];
		$thestore[0]['username'] = $formvalues['username'];
		$thestore[0]['url'] = $formvalues['url'];
		
		if(count($thestore) > 0){
			$formvalues['stores'] = $thestore;
		}
		// check for auto approved
		if(!isArrayKeyAnEmptyString('isapproved', $formvalues)){
			if($formvalues['isapproved'] == 1){
				$formvalues['status'] = 1;
				$formvalues['dateapproved'] = date('Y-m-d H:i:s');
				$formvalues['approvedbyid'] = $session->getVar('userid');
			}
		}
		
		// check if to create user
		if(!isArrayKeyAnEmptyString('createuser', $formvalues) || !isArrayKeyAnEmptyString('createuserandinvite', $formvalues)){
			$admins = array(); 
			if(!isArrayKeyAnEmptyString('createdby', $formvalues)){
				$admins[0]['createdby'] = $session->getVar('userid');
			}
			if(!isArrayKeyAnEmptyString('id', $formvalues)){
				$admins[0]['merchantid'] = $formvalues['id'];
			}
			if($formvalues['type'] == 2){
				$admins[0]['firstname'] = !isArrayKeyAnEmptyString('firstname', $formvalues) ? $formvalues['firstname'] : NULL;
				$admins[0]['lastname'] = !isArrayKeyAnEmptyString('lastname', $formvalues) ? $formvalues['lastname'] : NULL;
			}
			if($formvalues['type'] == 1){
				$admins[0]['firstname'] = $formvalues['contactperson'];
				$admins[0]['lastname'] = '.';
			}
			$admins[0]['email'] = $formvalues['email'];
			$admins[0]['phone'] = getFullPhone($formvalues['phone']);
			$admins[0]['type'] = 3;
			$admins[0]['isactive'] = 0;
			$admins[0]['agreedtoterms'] = 0;
			$admins[0]['usergroups'][0]["groupid"] = 3;
			
			if(!isArrayKeyAnEmptyString('createuserandinvite', $formvalues)){
				$admins[0]['isinvited'] = 1;
				$admins[0]['invitedbyid'] = $session->getVar('userid');
				$admins[0]['dateinvited'] = date('Y-m-d');
			}
			if(count($admins) > 0){
				$formvalues['admins'] = $admins;
			}
		}
		
		debugMessage($formvalues); // exit();
		parent::processPost($formvalues);
	}
	
	# determine if the username has already been assigned
	function usernameExists($username =''){
		$conn = Doctrine_Manager::connection();
		# validate unique username and email
		$id_check = "";
		if(!isEmptyString($this->getID())){
			$id_check = " AND merchantid <> '".$this->getID()."' ";
		}
		
		if(isEmptyString($username)){
			$username = $this->getStore()->getUsername();
		}
		$query = "SELECT id FROM store WHERE username = '".$username."' AND username <> '' ".$id_check;
		// debugMessage($query);
		$result = $conn->fetchOne($query);
		// debugMessage($result);
		if(isEmptyString($result)){
			return false;
		}
		return true;
	}
	# determine if the email has already been assigned
	function emailExists($email =''){
		$conn = Doctrine_Manager::connection();
		# validate unique username and email
		$id_check = "";
		if(!isEmptyString($this->getID())){
			$id_check = " AND id <> '".$this->getID()."' ";
		}
		
		if(isEmptyString($email)){
			$email = $this->getEmail();
		}
		$query = "SELECT id FROM useraccount WHERE email = '".$email."' AND email <> '' ".$id_check;
		// debugMessage($ref_query);
		$result = $conn->fetchOne($query);
		// debugMessage($ref_result);
		if(isEmptyString($result)){
			return false;
		}
		return true;
	}
	/**
     * Overide  to save persons relationships
     *	@return true if saved, false otherwise
     */
    function afterSave(){
    	$session = SessionWrapper::getInstance();
    	$conn = Doctrine_Manager::connection();
    	$update = false;
    	
    	# save changes 
    	if($update){
    		$this->save();
    	}
    	
    	// find any duplicates and delete them
    	$duplicates = $this->getDuplicates();
		if($duplicates->count() > 0){
			$duplicates->delete();
		}
		
		// send email invitation
		if($this->getAdmin()->hasBeenInvited()){
			$this->getAdmin()->sendProfileInvitationNotification($this->getID());
		}
		
    	// exit();
    	return true;
    }
	# find duplicates after save
	function getDuplicates(){
		if($this->isCompany()){
			$q = Doctrine_Query::create()->from('Merchant m')->where("m.type = 1 AND m.orgname = '".$this->getOrgName()."' AND m.category = '".$this->getCategory()."' AND m.id <> '".$this->getID()."' ");
		}
		if($this->isPerson()){
			$q = Doctrine_Query::create()->from('Merchant m')->where("m.type = 2 AND m.firstname = '".$this->getFirstName()."' AND m.lastname = '".$this->getLastName()."' AND m.id <> '".$this->getID()."' ");
		}	
		
		$result = $q->execute();
		return $result;
	}
	# determine if merchant is a person
	function isPerson(){
		return $this->getType() == 2 ? true : false;
	}
	# determine if merchant is a company
	function isCompany(){
		return $this->getType() == 1 ? true : false;
	}
	# determine if merchant is approved
	function isPending(){
		return $this->getStatus() == 0 ? true : false;
	}
	# determine if merchant is pending
	function isApproved(){
		return $this->getStatus() == 1 ? true : false;
	}
	# determine if merchant is rejected
	function isRejected(){
		return $this->getStatus() == 2 ? true : false;
	}
	function isDeactivated(){
		return $this->getStatus() == 3 ? true : false;
	}
	# the default store
	function getStore() {
		$store = $this->getStores()->get(0);
		if(!$store){
			$store = new Store();
		}
		return $store;
	}
	# the default admin user
	function getAdmin() {
		$admin = $this->getAdmins()->get(0);
		if(!$admin){
			$admin = new UserAccount();
		}
		return $admin;
	}
	# function to determine the user's profile path
	function getProfilePath() {
		$url = '';
		$store = $this->getStores()->get(0);
		if(!isEmptyString($store->getID())){
			$url = $store->getUrl();
		}
		return $url;
	}
	# default store url
	function getDefaultStore() {
		$view = new Zend_View();
		return $view->serverUrl($view->baseUrl('store/'));
	}
	# approve a store 
	function approve($status){
		$session = SessionWrapper::getInstance(); 
		$userid = $session->getVar('userid');
		$this->setStatus($status);
		$this->setDateApproved(date('Y-m-d H:i:s'));
		$this->setApprovedByID($userid);
		$this->getAdmin()->setActivationKey($this->getAdmin()->generateActivationKey());
		// save status change 
		try {
			$this->save();
		} catch (Exception $e) {
			$session->setVar(ERROR_MESSAGE, 'An error occured in updating status. '.$e->getMessage());
			return false;
		}
		
		$this->getAdmin()->sendMerchantApprovalNotification();
		
		return true;
	}
	# merchant name dependent on type
	function getName() {
		return $this->isPerson() ? $this->getFirstName()." ".$this->getLastName() : $this->getOrgName();
	}
	
}
?>