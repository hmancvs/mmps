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
		# override the not null and not blank properties for the createdby column in the BaseEntity
		$this->hasColumn('createdby', 'integer', 11);
	}
	/**
	 * Contructor method for custom functionality - add the fields to be marked as dates
	 */
	public function construct() {
		parent::construct();
		
		$this->addDateFields(array('dateapproved'));
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
	}
	/*
	 * Pre process model data
	 */
	function processPost($formvalues) {
		// trim spaces from the name field
		
		// debugMessage($formvalues); exit();
		parent::processPost($formvalues);
	}
}
?>