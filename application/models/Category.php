<?php

/**
 * Model for a a category from which the commodity categories, price categories extend 
 *
 */

class Category extends BaseEntity {
	
	public function setTableDefinition() {
		#add the table definitions from the parent table
		parent::setTableDefinition();
		$this->setTableName('category');
		
		$this->hasColumn('name', 'string', 255, array('notnull' => true, 'notblank' => true));
		$this->hasColumn('description', 'string', 500);
		$this->hasColumn('parentid', 'integer', null); 
		$this->hasColumn('storeid', 'integer', null); 
		$this->hasColumn('type', 'integer', null, array('default' => 2)); 
		$this->hasColumn('image', 'string', 255);
		$this->hasColumn('meta_description', 'string', 500);
		$this->hasColumn('code', 'string', 10);
		$this->hasColumn('defaultprice', 'decimal', 10, array('default' => NULL));
		$this->hasColumn('status', 'integer', null); 
		$this->hasColumn('sortorder', 'integer', null); 
		$this->hasColumn('level', 'integer', null); 
		$this->hasColumn('column', 'integer', null); 
	}
	# custom fieldds
	protected $addtoproduct;
	protected $productid;
	function getaddtoproduct(){
		return $this->addtoproduct; 
	}
	function setaddtoproduct($addtoproduct) {
		$this->addtoproduct = $addtoproduct;
	}
	function getproductid(){
		return $this->productid; 
	}
	function setproductid($productid) {
		$this->productid = $productid;
	}
	/**
	 * Contructor method for custom functionality - add the fields to be marked as dates
	 */
	public function construct() {
		parent::construct();
		// set the custom error messages
       	$this->addCustomErrorMessages(array(
       									"name.notblank" => $this->translate->_("global_name_error"),	
       									"name.length" => $this->translate->_("global_name_length_error")						
       	       						));
	}
	/*
	 * Relationships for the model
	 */
	public function setUp() {
		parent::setUp(); 
		$this->hasOne('Category as parent', 
								array(
									'local' => 'parentid',
									'foreign' => 'id'
								)
						);
		$this->hasOne('Store as store', 
								array(
									'local' => 'storeid',
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
		if(isArrayKeyAnEmptyString('storeid', $formvalues)){
			unset($formvalues['storeid']); 
		}
		if(isArrayKeyAnEmptyString('parentid', $formvalues)){
			unset($formvalues['parentid']); 
		}
		if(isArrayKeyAnEmptyString('column', $formvalues)){
			unset($formvalues['column']); 
		}
		if(isArrayKeyAnEmptyString('level', $formvalues)){
			unset($formvalues['level']); 
		}
		if(isArrayKeyAnEmptyString('type', $formvalues)){
			unset($formvalues['type']); 
		}
		if(isArrayKeyAnEmptyString('status', $formvalues)){
			unset($formvalues['status']); 
		}
		if(isArrayKeyAnEmptyString('sortorder', $formvalues)){
			unset($formvalues['sortorder']); 
		}
		if(isArrayKeyAnEmptyString('defaultprice', $formvalues)){
			unset($formvalues['defaultprice']); 
		}
		if(!isArrayKeyAnEmptyString('addtoproduct', $formvalues)){
			if($formvalues['addtoproduct'] == 1){
				$this->setaddtoproduct(1);
			}
		}
		if(isEmptyString($formvalues['id'])){
			$product = new Product();
			$category = new Category();
			$this->setproductid($formvalues['productid']);
			$product->populate($this->getproductid());
			$category->populate($formvalues['parentid']);
			if($category->getID() == $product->getStore()->getMerchant()->getCategoryID()){
				$formvalues['level'] = 2;
			} else {
				$formvalues['level'] = 3;
			}
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
		
		// check if user specified to add admin user and to invite them
		if($this->getaddtoproduct() == 1){
			// new category being added
			$prodcat = new ProductCategory();
			$data_array = array(
							'productid' => $this->getproductid(),
							'categoryid' => $this->getID()
						);
			
			$prodcat->processPost($data_array);
			// debugMessage($prodcat->toArray());
			$prodcat->save();
			
			// parent category being added
			$product = new Product();
			$product->populate($this->getproductid());
			$parentcat = $product->getCategoryEntry($this->getParentID());
			if($parentcat->count() == 0){
				$prodcat = new ProductCategory();
				$data_array = array(
								'productid' => $this->getproductid(),
								'categoryid' => $this->getParentID()
							);
				
				$prodcat->processPost($data_array);
				// debugMessage($prodcat->toArray());
				$prodcat->save();
			}
		}
    	// exit();
    	return true;
    }
	# find duplicates after save
	function getDuplicates(){
		$q = Doctrine_Query::create()->from('Category c')->where("c.type = '".$this->getType()."' AND c.name = '".$this->getName()."' AND c.parentid = '".$this->getParentID()."' AND c.createdby = '".$this->getCreatedBy()."' AND c.id <> '".$this->getID()."' ");
		
		$result = $q->execute();
		return $result;
	}
}

?>