<?php

/**
 * Model for product attribute
 */
class ProductAttribute extends BaseRecord  {
	
	public function setTableDefinition() {
		parent::setTableDefinition();
		$this->setTableName('product_attribute');
		
		$this->hasColumn('productid', 'integer', array( 'notnull' => true, 'notblank' => true));
		$this->hasColumn('field', 'string', 255, array( 'notnull' => true, 'notblank' => true));
		$this->hasColumn('value', 'string', 500, array( 'notnull' => true, 'notblank' => true));
		$this->hasColumn('order', 'integer', null, array('default' => NULL));
	}
	/**
	 * Contructor method for custom functionality - add the fields to be marked as dates
	 */
	public function construct() {
		parent::construct();
		
		$this->addCustomErrorMessages(array(
										"productid.notblank" => $this->translate->_("product_attribute_name_error"),
										"field.notblank" => $this->translate->_("product_attribute_field_error"),
										"value.notblank" => $this->translate->_("product_attribute_value_error")
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