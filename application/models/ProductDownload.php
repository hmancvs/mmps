<?php

/**
 * Model for product downloads
 */
class ProductCategory extends BaseRecord  {
	
	public function setTableDefinition() {
		parent::setTableDefinition();
		$this->setTableName('product_download');
		
		$this->hasColumn('productid', 'integer', null, array( 'notnull' => true, 'notblank' => true));
		$this->hasColumn('categoryid', 'integer', null, array('default' => NULL));
		$this->hasColumn('order', 'integer', null, array('default' => NULL));
	}
	/**
	 * Contructor method for custom functionality - add the fields to be marked as dates
	 */
	public function construct() {
		parent::construct();
		
		$this->addDateFields(array('dateapproved'));
		// set the custom error messages
		$this->addCustomErrorMessages(array(
										"productid.notblank" => $this->translate->_("product_category_product_error"),
       	       						));     
	}
	/*
	 * Relationships for the model
	 */
	public function setUp() {
		parent::setUp(); 
		$this->hasOne('Product as product', 
								array(
									'local' => 'productid',
									'foreign' => 'id'
								)
						);
		$this->hasOne('Category as category', 
								array(
									'local' => 'categoryid',
									'foreign' => 'id'
								)
						);
	}
	/*
	 * Pre process model data
	 */
	function processPost($formvalues) {
		$session = SessionWrapper::getInstance(); 
		
		// trim spaces from the name field
		if(isArrayKeyAnEmptyString('order', $formvalues)){
			unset($formvalues['order']); 
		}
		// check if to create user
		// debugMessage($formvalues); // exit();
		parent::processPost($formvalues);
	}
}
?>