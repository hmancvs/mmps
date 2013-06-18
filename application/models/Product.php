<?php

/**
 * Model for products
 */
class Product extends BaseEntity  {
	
	public function setTableDefinition() {
		parent::setTableDefinition();
		$this->setTableName('product');
		
		$this->hasColumn('storeid', 'integer', null, array( 'notnull' => true, 'notblank' => true));
		$this->hasColumn('refno', 'string', 50, array('notnull' => true, 'notblank' => true));
		$this->hasColumn('name', 'string', 50, array('notnull' => true, 'notblank' => true));
		$this->hasColumn('model', 'string', 50);
		$this->hasColumn('serialno', 'string', 25);
		$this->hasColumn('manufacturer', 'string', 50);
		$this->hasColumn('description', 'string', 65565);
		
		$this->hasColumn('type', 'integer', null, array( 'notnull' => true, 'notblank' => true));
		$this->hasColumn('categoryid', 'integer', null, array('default' => NULL));
		$this->hasColumn('category_class', 'integer', null, array('default' => 1));
		$this->hasColumn('status', 'integer', null, array('default' => 1));
		$this->hasColumn('sortorder', 'integer', null, array('default' => NULL));
		$this->hasColumn('quantity', 'decimal', 10, array('default' => NULL));
		$this->hasColumn('showquantity', 'integer', null, array('default' => 1));
		$this->hasColumn('subtract', 'integer', null, array('default' => 1));
		$this->hasColumn('minimum', 'decimal', 10, array('default' => NULL));
		$this->hasColumn('email_minimum', 'integer', null, array('default' => 1));
		$this->hasColumn('shipping', 'integer', null, array('default' => 0));
		
		$this->hasColumn('unitprice', 'decimal', 10, array('default' => NULL));
		$this->hasColumn('netprice', 'decimal', 10, array('default' => NULL));
		$this->hasColumn('trxfee', 'decimal', 10, array('default' => NULL));
		$this->hasColumn('cost', 'decimal', 10, array('default' => 0));
		$this->hasColumn('currency', 'integer', null, array('default' => NULL));
		$this->hasColumn('length', 'decimal', 10, array('default' => NULL));
		$this->hasColumn('width', 'decimal', 10, array('default' => NULL));
		$this->hasColumn('height', 'decimal', 10, array('default' => NULL));
		$this->hasColumn('dimensionunit', 'integer', null, array('default' => 2));
		$this->hasColumn('weight', 'decimal', 10, array('default' => NULL));
		$this->hasColumn('weightunit', 'integer', null, array('default' => 1));
		$this->hasColumn('points', 'decimal', 10, array('default' => NULL));
		$this->hasColumn('dateavailable', 'date', array('default' => NULL));
		$this->hasColumn('dateexpire', 'date', array('default' => NULL));
		$this->hasColumn('meta_description', 'string', 255);
		$this->hasColumn('meta_keyword', 'string', 255);
		$this->hasColumn('profilephoto', 'string', 50);
	}
	/**
	 * Contructor method for custom functionality - add the fields to be marked as dates
	 */
	public function construct() {
		parent::construct();
		
		$this->addDateFields(array('dateapproved','dateavailable','dateexpire'));
		// set the custom error messages
		$this->addCustomErrorMessages(array(
										"storeid.notblank" => $this->translate->_("product_store_error"),
										"refno.notblank" => $this->translate->_("product_refno_error"),
										"name.notblank" => $this->translate->_("product_name_error"),
										"type.notblank" => $this->translate->_("product_type_error")
       	       						));     
	}
	/*
	 * Relationships for the model
	 */
	public function setUp() {
		parent::setUp(); 
		$this->hasOne('Store as store', 
								array(
									'local' => 'storeid',
									'foreign' => 'id'
								)
						);
		$this->hasOne('Category as category', 
								array(
									'local' => 'categoryid',
									'foreign' => 'id'
								)
						);
		$this->hasMany('ProductAttribute as attributes',
					 		array(
								'local' => 'id',
								'foreign' => 'productid'
							)
						);
		$this->hasMany('ProductCategory as categories',
					 		array(
								'local' => 'id',
								'foreign' => 'productid'
							)
						);
	}
	/**
	 * Custom model validation
	 */
	function validate() {
		# execute the column validation 
		parent::validate();
		
	}
	/*
	 * Pre process model data
	 */
	function processPost($formvalues) {
		$session = SessionWrapper::getInstance(); 
		
		if(!isArrayKeyAnEmptyString('tab', $formvalues)){
			// general tab
			if($formvalues['tab'] == 'general'){
				if(isArrayKeyAnEmptyString('storeid', $formvalues)){
					unset($formvalues['storeid']); 
				}
				if(isArrayKeyAnEmptyString('type', $formvalues)){
					unset($formvalues['type']); 
				}
			}
			// spec tab
			if($formvalues['tab'] == 'spec'){
				if(isArrayKeyAnEmptyString('length', $formvalues)){
					$formvalues['length'] = NULL; 
				}
				if(isArrayKeyAnEmptyString('width', $formvalues)){
					$formvalues['width'] = NULL;
				}
				if(isArrayKeyAnEmptyString('height', $formvalues)){
					$formvalues['height'] = NULL;
				}
				if(isArrayKeyAnEmptyString('dimensionunit', $formvalues)){
					$formvalues['dimensionunit'] = NULL;
				}
				if(isArrayKeyAnEmptyString('weight', $formvalues)){
					$formvalues['weight'] = NULL; 
				}
				if(isArrayKeyAnEmptyString('weightunit', $formvalues)){
					$formvalues['weightunit'] = NULL;
				}
				if(isArrayKeyAnEmptyString('points', $formvalues)){
					$formvalues['points'] = NULL; 
				}
				# process the attribures
				$detailsarray = array();
				if(!isArrayKeyAnEmptyString('customattributes', $formvalues)){
					foreach ($formvalues['customattributes'] as $key => $value){
						if(isEmptyString($value['field'])){
							unset($value[$key]);
						} else {
							$detailsarray[$key] = $value;
							if(!isArrayKeyAnEmptyString('id', $value)){
								$detailsarray[$key]['id'] = $value['id'];
							}
						}
					}
				}
				
				// debugMessage($detailsarray);
				if(count($detailsarray) > 0){
					$formvalues['attributes'] = $detailsarray;
				}
			}
			// category tab
			if($formvalues['tab'] == 'category'){
				if(isArrayKeyAnEmptyString('categoryid', $formvalues)){
					unset($formvalues['categoryid']); 
				}
				if(isArrayKeyAnEmptyString('category_class', $formvalues)){
					unset($formvalues['category_class']); 
				}
			}
			// category price
			if($formvalues['tab'] == 'prices' || !isArrayKeyAnEmptyString('popupadd', $formvalues)){
				if(isArrayKeyAnEmptyString('quantity', $formvalues)){
					$formvalues['quantity'] = NULL; 
				}
				if(isArrayKeyAnEmptyString('showquantity', $formvalues)){
					$formvalues['showquantity'] = NULL; 
				}
				if(isArrayKeyAnEmptyString('unitprice', $formvalues)){
					$formvalues['unitprice'] = NULL; 
				}
				if(isArrayKeyAnEmptyString('netprice', $formvalues)){
					$formvalues['netprice'] = NULL;  
				}
				if(isArrayKeyAnEmptyString('trxfee', $formvalues)){
					$formvalues['trxfee'] = NULL; 
				}
				if(isArrayKeyAnEmptyString('cost', $formvalues)){
					$formvalues['cost'] = NULL;  
				}
				if(isArrayKeyAnEmptyString('currency', $formvalues)){
					unset($formvalues['currency']); 
				}
			}
			// category account
			if($formvalues['tab'] == 'account'){
				if(isArrayKeyAnEmptyString('status', $formvalues)){
					unset($formvalues['status']); 
				}
				if(isArrayKeyAnEmptyString('sortorder', $formvalues)){
					unset($formvalues['sortorder']); 
				}
				if(isArrayKeyAnEmptyString('minimum', $formvalues)){
					$formvalues['minimum'] = NULL; 
				}
				if(isArrayKeyAnEmptyString('email_minimum', $formvalues)){
					unset($formvalues['email_minimum']); 
				}
				if(isArrayKeyAnEmptyString('subtract', $formvalues)){
					unset($formvalues['subtract']); 
				}
				if(isArrayKeyAnEmptyString('shipping', $formvalues)){
					unset($formvalues['shipping']); 
				}
				if(isArrayKeyAnEmptyString('dateavailable', $formvalues)){
					$formvalues['dateavailable'] = NULL; 
				}
				if(isArrayKeyAnEmptyString('dateexpire', $formvalues)){
					$formvalues['dateexpire'] = NULL; 
				}
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
		
    	// exit();
    	return true;
    }
	# find duplicates after save
	function getDuplicates(){
		$q = Doctrine_Query::create()->from('Product p')->where("p.name = '".$this->getName()."' AND p.refno = '".$this->getRefNo()."' AND p.type = '".$this->getType()."' AND p.id <> '".$this->getID()."' ");
		
		$result = $q->execute();
		return $result;
	}
	# relative path to profile image
	function hasProfileImage(){
		$real_path = APPLICATION_PATH.DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."public".DIRECTORY_SEPARATOR."uploads".DIRECTORY_SEPARATOR."stores".DIRECTORY_SEPARATOR."store_";
		$real_path = $real_path.$this->getStoreID().DIRECTORY_SEPARATOR."product_".$this->getID().DIRECTORY_SEPARATOR."avatar".DIRECTORY_SEPARATOR."large_".$this->getProfilePhoto();
		if(file_exists($real_path) && !isEmptyString($this->getProfilePhoto())){
			return true;
		}
		return false;
	}
	# determine if person has profile image
	function getRelativeProfilePicturePath(){
		$real_path = APPLICATION_PATH.DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."public".DIRECTORY_SEPARATOR."uploads".DIRECTORY_SEPARATOR."stores".DIRECTORY_SEPARATOR."store_";
		$real_path = $real_path.$this->getStoreID().DIRECTORY_SEPARATOR."product_".$this->getID().DIRECTORY_SEPARATOR."avatar".DIRECTORY_SEPARATOR."medium_".$this->getProfilePhoto();
		if(file_exists($real_path) && !isEmptyString($this->getProfilePhoto())){
			return $real_path;
		}
		$real_path = APPLICATION_PATH.DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."public".DIRECTORY_SEPARATOR."uploads".DIRECTORY_SEPARATOR."default".DIRECTORY_SEPARATOR."default_medium_product.jpg";
		return $real_path;
	}
	
	# determine path to small profile picture
	function getSmallPicturePath() {
		$baseUrl = Zend_Controller_Front::getInstance()->getBaseUrl();
		$path = $baseUrl.'/uploads/default/default_small_product.jpg';
		if($this->hasProfileImage()){
			$path = $baseUrl.'/uploads/stores/store_'.$this->getStoreID().'/product_'.$this->getID().'/avatar/small_'.$this->getProfilePhoto();
		}
		return $path;
	}
	# determine path to thumbnail profile picture
	function getThumbnailPicturePath() {
		$baseUrl = Zend_Controller_Front::getInstance()->getBaseUrl();
		$path = $baseUrl.'/uploads/default/default_thumbnail_product.jpg';
		if($this->hasProfileImage()){
			$path = $baseUrl.'/uploads/stores/store_'.$this->getStoreID().'/product_'.$this->getID().'/avatar/thumbnail_'.$this->getProfilePhoto();
		}
		return $path;
	}
	# determine path to medium profile picture
	function getMediumPicturePath() {
		$baseUrl = Zend_Controller_Front::getInstance()->getBaseUrl();
		$path = $baseUrl.'/uploads/default/default_medium_product.jpg';
		if($this->hasProfileImage()){
			$path = $baseUrl.'/uploads/stores/store_'.$this->getStoreID().'/product_'.$this->getID().'/avatar/medium_'.$this->getProfilePhoto();
		}
		return $path;
	}
	# determine path to large profile picture
	function getLargePicturePath() {
		$baseUrl = Zend_Controller_Front::getInstance()->getBaseUrl();
		$path = $baseUrl.'/uploads/default/default_large_product.jpg';
		if($this->hasProfileImage()){
			$path = $baseUrl.'/uploads/stores/store_'.$this->getStoreID().'/product_'.$this->getID().'/avatar/large_'.$this->getProfilePhoto();
		}
		return $path;
	}
	# fetch next id
	function getLastInsertID(){
		$conn = Doctrine_Manager::connection();
		$query = "SELECT max(id) FROM product ";
		$result = $conn->fetchOne($query);
		return $result;
	}
	# determine the product attributes ordered by 'order'
    function getAllAttributes(){
    	$q = Doctrine_Query::create()->from('ProductAttribute p')->where("p.productid = '".$this->getID()."'")->orderby('p.order ASC');
		$result = $q->execute();
		return $result;
    }
	# check for product entry in product_category
	function getCategoryEntry($catid){
		$q = Doctrine_Query::create()->from('ProductCategory pc')->where("pc.productid = '".$this->getID()."' AND pc.categoryid = '".$catid."'");
		
		$result = $q->execute();
		return $result;
	}
	# determine if product is downloadable
	function isDownloadable(){
		return $this->getType() == 2 ? true : false;
	}
}
?>