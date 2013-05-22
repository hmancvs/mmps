<?php

/**
 * Model for merchants
 */
class Merchant extends BaseRecord  {
	
	public function setTableDefinition() {
		parent::setTableDefinition();
		$this->setTableName('merchant');
		
		$this->hasColumn('type', 'integer', null, array( 'notnull' => true, 'notblank' => true, 'default' => '1'));
		$this->hasColumn('firstname', 'string', 255);
		$this->hasColumn('lastname', 'string', 255);
		$this->hasColumn('orgname', 'string', 255);
		$this->hasColumn('lastname', 'string', 255);
		$this->hasColumn('email', 'string', 50, array('notnull' => true, 'notblank' => true));
		$this->hasColumn('phone', 'string', 15, array('notnull' => true, 'notblank' => true));
		$this->hasColumn('phone2', 'string', 15);
		$this->hasColumn('status', 'integer', null, array('default' => '1')); # 1=Created, 2=Approved, 3=Rejected
		$this->hasColumn('dateapproved', 'date');
		$this->hasColumn('approvedbyid', 'integer', null);
	}
	/**
	 * Contructor method for custom functionality - add the fields to be marked as dates
	 */
	public function construct() {
		parent::construct();
		
		$this->addDateFields(array('dateapproved'));
		// set the custom error messages
		$this->addCustomErrorMessages(array(
										"type.notblank" => $this->translate->_("merchant_type_error"),
										"phone.notblank" => $this->translate->_("merchant_phone_error"),
										"email.notblank" => $this->translate->_("merchant_email_error"),
       	       						));     
	}
	/*
	 * Relationships for the model
	 */
	public function setUp() {
		parent::setUp(); 
		
		
	}
	/*
	 * Pre process model data
	 */
	function processPost($formvalues) {
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
		// debugMessage($formvalues); exit();
		parent::processPost($formvalues);
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
    	// exit();
    	return true;
    }
	# find duplicates after save
	function getDuplicates(){
		$q = Doctrine_Query::create()->from('Merchant m')->where("m.type = '".$this->getType()."' AND ((m.firstname = '".$this->getFirstName()."' AND m.lastname = '".$this->getLastName()."') 
				OR (m.orgname = '".$this->getOrgName()."')) AND m.id <> '".$this->getID()."' ");
		
		$result = $q->execute();
		return $result;
	}
}
?>