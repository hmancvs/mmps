<?php

/**
 * Model for store
 */
class Store extends BaseEntity  {
	
	public function setTableDefinition() {
		parent::setTableDefinition();
		$this->setTableName('store');
		
		$this->hasColumn('merchantid', 'integer', null);
		$this->hasColumn('name', 'string', 50, array( 'notnull' => true, 'notblank' => true));
		$this->hasColumn('username', 'string', 15);
		$this->hasColumn('url', 'string', 255);
		$this->hasColumn('tagline', 'string', 255);
		$this->hasColumn('description', 'string', 500);
		$this->hasColumn('theme', 'integer', null, array('default'=>1));
		$this->hasColumn('logotype', 'integer', null, array('default'=>1));
		$this->hasColumn('menuconfig', 'integer', null, array('default'=>1));
		$this->hasColumn('frontconfig', 'integer', null, array('default'=>1));
		$this->hasColumn('logo', 'string', 255);
		$this->hasColumn('cover', 'string', 255);
		# override the not null and not blank properties for the createdby column in the BaseEntity
		$this->hasColumn('createdby', 'integer', 11);
	}
	/**
	 * Contructor method for custom functionality - add the fields to be marked as dates
	 */
	public function construct() {
		parent::construct();
		
		// set the custom error messages
		$this->addCustomErrorMessages(array(
										"name.notblank" => $this->translate->_("merchant_storename_error")
       	       						));     
	}
	/*
	 * Relationships for the model
	 */
	public function setUp() {
		parent::setUp(); 
		
		$this->hasOne('Merchant as merchant', 
								array(
									'local' => 'merchantid',
									'foreign' => 'id'
								)
						);
		$this->hasOne('UserAccount as creator', 
								array(
									'local' => 'createdby',
									'foreign' => 'id'
								)
						);
		$this->hasMany('Product as products',
					 		array(
								'local' => 'id',
								'foreign' => 'storeid'
							)
						);
	}
	/*
	 * Pre process model data
	 */
	function processPost($formvalues) {
		// trim spaces from the name field
		if(isArrayKeyAnEmptyString('theme', $formvalues)){
			unset($formvalues['theme']); 
		}
		if(isArrayKeyAnEmptyString('logotype', $formvalues)){
			unset($formvalues['logotype']); 
		}
		if(isArrayKeyAnEmptyString('menuconfig', $formvalues)){
			unset($formvalues['menuconfig']); 
		}
		if(isArrayKeyAnEmptyString('frontconfig', $formvalues)){
			unset($formvalues['frontconfig']); 
		}
		// debugMessage($formvalues); exit();
		parent::processPost($formvalues);
	}
	// determine a store from its username
	function findByUsername($username) {
		# query active user details using email
		$q = Doctrine_Query::create()->from('Store s')->where('s.username = ?', $username);
		$result = $q->fetchOne(); 
		
		if($result){
			$data = $result->toArray(); 
		} else {
			$data = $this->toArray(); 
		}
		
		# merge all the data including the user groups 
		$this->merge($data);
		# also assign the identifier for the object so that it can be updated
		if($result){
			$this->assignIdentifier($data['id']);
		} 
		
		return true; 
	}
	# determine the url for the store
	function getStoreUrl(){
		$view = new Zend_View();
		return $view->serverUrl($view->baseUrl('store/'.$this->getUserName()));
	}
	# function to determine the user's profile path
	function getProfilePath() {
		$url = $this->getDefaultStore();
		$storeid = $this->getID();
		if(!isEmptyString($storeid)){
			$view = new Zend_View();
			$url =  $view->serverUrl($view->baseUrl('store/'.$this->getUserName()));
		}
		return $url;
	}
	# default store url
	function getDefaultStore() {
		$view = new Zend_View();
		return $view->serverUrl($view->baseUrl('store/'));
	}
	# relative path to profile image
	function hasLogoImage(){
		$real_path = APPLICATION_PATH.DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."public".DIRECTORY_SEPARATOR."uploads".DIRECTORY_SEPARATOR."stores".DIRECTORY_SEPARATOR."store_";
		$real_path = $real_path.$this->getID().DIRECTORY_SEPARATOR."logo".DIRECTORY_SEPARATOR."large_".$this->getLogo();
		if(file_exists($real_path) && !isEmptyString($this->getLogo())){
			return true;
		}
		return false;
	}
	# determine path to medium profile picture
	function getLogoPath() {
		$baseUrl = Zend_Controller_Front::getInstance()->getBaseUrl();
		$path = $baseUrl.'/uploads/default/default_logo.png';
		if($this->hasLogoImage()){
			$path = $baseUrl.'/uploads/stores/store_'.$this->getID().'/logo/logo_'.$this->getLogo();
		}
		return $path;
	}
	# determine path to large profile picture
	function getLargeLogoPath() {
		$baseUrl = Zend_Controller_Front::getInstance()->getBaseUrl();
		$path = $baseUrl.'/uploads/default/default_logo.png';
		if($this->hasLogoImage()){
			$path = $baseUrl.'/uploads/stores/store_'.$this->getID().'/logo/large_'.$this->getLogo();
		}
		return $path;
	}
	# relative path to profile image
	function hasCoverImage(){
		$real_path = APPLICATION_PATH.DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."public".DIRECTORY_SEPARATOR."uploads".DIRECTORY_SEPARATOR."stores".DIRECTORY_SEPARATOR."store_";
		$real_path = $real_path.$this->getID().DIRECTORY_SEPARATOR."cover".DIRECTORY_SEPARATOR."large_".$this->getcover();
		if(file_exists($real_path) && !isEmptyString($this->getcover())){
			return true;
		}
		return false;
	}
	# determine path to medium profile picture
	function getCoverPath() {
		$baseUrl = Zend_Controller_Front::getInstance()->getBaseUrl();
		$path = $baseUrl.'/uploads/default/default_cover.png';
		if($this->hasCoverImage()){
			$path = $baseUrl.'/uploads/stores/store_'.$this->getID().'/cover/cover_'.$this->getcover();
		}
		return $path;
	}
	# determine path to large profile picture
	function getLargeCoverPath() {
		$baseUrl = Zend_Controller_Front::getInstance()->getBaseUrl();
		$path = $baseUrl.'/uploads/default/default_cover.png';
		if($this->hasCoverImage()){
			$path = $baseUrl.'/uploads/stores/store_'.$this->getID().'/cover/large_'.$this->getcover();
		}
		return $path;
	}
	# check if store is using text as image
	function isTextLogo(){
		return $this->getLogoType() == 2 ? true : false;
	}
	# check if store menu is configured for products
	function isCategoryMenu(){
		return $this->getMenuConfig() == 1 ? true : false;
	}
	# check if store menu is configured for categories
	function isProdductMenu(){
		return $this->getMenuConfig() == 2 ? true : false;
	}
	# determine all featured products
	function getFeaturedProducts(){
		return $this->getProducts();
	}
}
?>