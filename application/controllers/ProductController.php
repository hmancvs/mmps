<?php

class ProductController extends SecureController  {
	/**
	 * Override unknown actions to enable ACL checking 
	 * 
	 * @see SecureController::getActionforACL()
	 *
	 * @return String
	 */
	public function getActionforACL() {
        $action = strtolower($this->getRequest()->getActionName()); 
		if($action == "add") {
			return ACTION_CREATE; 
		}
    	if($action == "addsuccess" || $action == 'picture') {
			return ACTION_VIEW; 
		}
		if($action == "delete" ) {
			return ACTION_VIEW; 
		}
		return parent::getActionforACL(); 
    }
    
	public function getResourceForACL(){
        return "User Account"; 
    }
    
	public function addAction(){}
	
 	public function addsuccessAction(){
		$session = SessionWrapper::getInstance(); 
     	$this->_helper->layout->disableLayout();
		$this->_helper->viewRenderer->setNoRender(TRUE);
		$formvalues = $this->_getAllParams();
		
		$session->setVar(SUCCESS_MESSAGE, "Successfully saved");
   		if(!isArrayKeyAnEmptyString('successmessage', $formvalues)){
			$session->setVar(SUCCESS_MESSAGE, decode($formvalues['successmessage']));
		}
		
		$product = new Product();
		$id = $product->getLastInsertID();
		$this->_helper->redirector->gotoUrl($this->view->baseUrl("product/view/id/".encode($id)));
    }
    
	public function pictureAction() {
		// disable rendering of the view and layout so that we can just echo the AJAX output 
	    $this->_helper->layout->disableLayout();
		// $this->_helper->viewRenderer->setNoRender(TRUE);
		
	    $session = SessionWrapper::getInstance(); 	
	    $config = Zend_Registry::get("config");
	    $this->_translate = Zend_Registry::get("translate"); 
		
	    $formvalues = $this->_getAllParams();
	    $step = $formvalues['step'];
	    
	    debugMessage($formvalues); 
		$product = new Product();
		$product->populate(decode($this->_getParam('id')));
		// debugMessage($product->toArray()); 
		
	    // uploading image
	    if($step == 'upload'){
			// only upload a file if the attachment field is specified		
			$upload = new Zend_File_Transfer();
			// set the file size in bytes
			$upload->setOptions(array('useByteString' => false));
			
			// Limit the extensions to the specified file extensions
			$upload->addValidator('Extension', false, $config->profilephoto->allowedformats);
		 	$upload->addValidator('Size', false, $config->profilephoto->maximumfilesize);
			
			// base path for profile pictures
			$destination_path = APPLICATION_PATH.DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."public".DIRECTORY_SEPARATOR."uploads".DIRECTORY_SEPARATOR."stores".DIRECTORY_SEPARATOR."store_".$product->getStoreID();
			// create store folder if doesnt exist
	    	if(!is_dir($destination_path)){
				mkdir($destination_path, 0755);
			}
			$destination_path = $destination_path.DIRECTORY_SEPARATOR."product_".$product->getID();
			// create product folder if doesnt exist
	    	if(!is_dir($destination_path)){
				mkdir($destination_path, 0755);
			}
	   		$destination_path = $destination_path.DIRECTORY_SEPARATOR."avatar";
			// create product folder if doesnt exist
	    	if(!is_dir($destination_path)){
				mkdir($destination_path, 0755);
			}
			
	    	// create archive folder 
			$archivefolder = $destination_path.DIRECTORY_SEPARATOR."archive";
			if(!is_dir($archivefolder)){
				mkdir($archivefolder, 0755);
			}
			// debugMessage($destination_path);
			
			$oldfilename = $product->getProfilePhoto();
			$upload->setDestination($destination_path);
			
			// the profile image info before upload
			$file = $upload->getFileInfo('profileimage');
			$uploadedext = findExtension($file['profileimage']['name']);
			$currenttime = mktime();
			$currenttime_file = $currenttime.'.'.$uploadedext;
			// debugMessage($file);
			
			$thefilename = $destination_path.DIRECTORY_SEPARATOR.'base_'.$currenttime_file;
			$thelargefilename = $destination_path.DIRECTORY_SEPARATOR.'large_'.$currenttime_file;
			$updateablefile = $destination_path.DIRECTORY_SEPARATOR.'base_'.$currenttime;
			$updateablelarge = $destination_path.DIRECTORY_SEPARATOR.'large_'.$currenttime;
			
			// rename the base image file 
			$upload->addFilter('Rename',  array('target' => $thefilename, 'overwrite' => true));		
			// exit();
			// process the file upload
			if($upload->receive()){
				// debugMessage('Completed');
				$file = $upload->getFileInfo('profileimage');
				// debugMessage($file);
				
				$basefile = $thefilename;
				// convert png to jpg
				if(in_array(strtolower($uploadedext), array('png','PNG','gif','GIF'))){
					ak_img_convert_to_jpg($thefilename, $updateablefile.'.jpg', $uploadedext);
					unlink($thefilename);
				}
				$basefile = $updateablefile.'.jpg';
				
				// new profilenames
				$newlargefilename = "large_".$currenttime_file;
				// generate and save thumbnails for sizes 250, 125 and 50 pixels
				resizeImage($basefile, $destination_path.DIRECTORY_SEPARATOR.'large_'.$currenttime.'.jpg', 400);
				resizeImage($basefile, $destination_path.DIRECTORY_SEPARATOR.'medium_'.$currenttime.'.jpg', 165);
				// unlink($thefilename);
				unlink($destination_path.DIRECTORY_SEPARATOR.'base_'.$currenttime.'.jpg');
				
				// exit();
				// update the useraccount with the new profile images
				try {
					$product->setProfilePhoto($currenttime.'.jpg');
					$product->save();
					
					// check if user already has profile picture and archive it
					$ftimestamp = current(explode('.', $product->getProfilePhoto()));
					
					$allfiles = glob($destination_path.DIRECTORY_SEPARATOR.'*.*');
					$currentfiles = glob($destination_path.DIRECTORY_SEPARATOR.'*'.$ftimestamp.'*.*');
					// debugMessage($currentfiles);
					$deletearray = array();
					foreach ($allfiles as $value) {
						if(!in_array($value, $currentfiles)){
							$deletearray[] = $value;
						}
					}
					// debugMessage($deletearray);
					if(count($deletearray) > 0){
						foreach ($deletearray as $afile){
							$afile_filename = basename($afile);
							rename($afile, $archivefolder.DIRECTORY_SEPARATOR.$afile_filename);
						}
					}
					
					$session->setVar(SUCCESS_MESSAGE, $this->_translate->translate("global_save_success"));
					$this->_helper->redirector->gotoUrl(decode($formvalues['cropurl']));
				} catch (Exception $e) {
					$session->setVar(ERROR_MESSAGE, $e->getMessage());
					$session->setVar(FORM_VALUES, $this->_getAllParams());
					$this->_helper->redirector->gotoUrl(decode($formvalues['failureurl']));
				}
			} else {
				// debugMessage($upload->getMessages());
				$uploaderrors = $upload->getMessages();
				$customerrors = array();
				if(!isArrayKeyAnEmptyString('fileUploadErrorNoFile', $uploaderrors)){
					$customerrors['fileUploadErrorNoFile'] = "Please browse for image on computer";
				}
				if(!isArrayKeyAnEmptyString('fileExtensionFalse', $uploaderrors)){
					$custom_exterr = sprintf($this->_translate->translate('upload_invalid_ext_error'), $config->profilephoto->allowedformats);
					$customerrors['fileExtensionFalse'] = $custom_exterr;
				}
				if(!isArrayKeyAnEmptyString('fileUploadErrorIniSize', $uploaderrors)){
					$custom_exterr = sprintf($this->_translate->translate('upload_invalid_size_error'), formatBytes($config->profilephoto->maximumfilesize,0));
					$customerrors['fileUploadErrorIniSize'] = $custom_exterr;
				}
				if(!isArrayKeyAnEmptyString('fileSizeTooBig', $uploaderrors)){
					$custom_exterr = sprintf($this->_translate->translate('upload_invalid_size_error'), formatBytes($config->profilephoto->maximumfilesize,0));
					$customerrors['fileSizeTooBig'] = $custom_exterr;
				}
				$session->setVar(ERROR_MESSAGE, 'The following errors occured <ul><li>'.implode('</li><li>', $customerrors).'</li></ul>');
				$session->setVar(FORM_VALUES, $this->_getAllParams());
				
				$this->_helper->redirector->gotoUrl(decode($formvalues['failureurl']));
			}
	    }
	    
	    if($step == 'crop'){
			$oldfile = "large_".$product->getProfilePhoto();
			$base = APPLICATION_PATH.DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."public".DIRECTORY_SEPARATOR."uploads".DIRECTORY_SEPARATOR."stores".DIRECTORY_SEPARATOR."store_";
			$base = $base.$product->getStoreID().DIRECTORY_SEPARATOR."product_".$product->getID().DIRECTORY_SEPARATOR."avatar".DIRECTORY_SEPARATOR;
			// debugMessage($product->toArray()); 
			$src = $base.$oldfile;
			
			$currenttime = mktime();
			$currenttime_file = $currenttime.'.jpg';
			$newlargefilename = $base."large_".$currenttime_file;
			$newmediumfilename = $base."medium_".$currenttime_file;
			$newthumbnailfilename = $base."thumbnail_".$currenttime_file;
			$newsmallfilename = $base."small_".$currenttime_file;
			
			// exit();
			$image = WideImage::load($src);
			$cropped1 = $image->crop($formvalues['x1'], $formvalues['y1'], $formvalues['w'], $formvalues['h']);
			$resized_1 = $cropped1->resize(300, 300, 'fill');
			$resized_1->saveToFile($newlargefilename);
			
			//$image2 = WideImage::load($src);
			$cropped2 = $image->crop($formvalues['x1'], $formvalues['y1'], $formvalues['w'], $formvalues['h']);
			$resized_2 = $cropped2->resize(165, 165, 'fill');
			$resized_2->saveToFile($newmediumfilename);
			
			//$image3 = WideImage::load($src);
			$cropped3 = $image->crop($formvalues['x1'], $formvalues['y1'], $formvalues['w'], $formvalues['h']);
			$resized_3 = $cropped3->resize(65, 65, 'fill');
			$resized_3->saveToFile($newthumbnailfilename);
			
			//$image4 = WideImage::load($src);
			$cropped4 = $image->crop($formvalues['x1'], $formvalues['y1'], $formvalues['w'], $formvalues['h']);
			$resized_4 = $cropped4->resize(45, 45, 'fill');
			$resized_4->saveToFile($newsmallfilename);
			
			$product->setProfilePhoto($currenttime_file);
			$product->save();
				
			// check if user already has profile picture and archive it
			$ftimestamp = current(explode('.', $product->getProfilePhoto()));
			$allfiles = glob($base.DIRECTORY_SEPARATOR.'*.*');
			$currentfiles = glob($base.DIRECTORY_SEPARATOR.'*'.$ftimestamp.'*.*');
			// debugMessage($currentfiles);
			$deletearray = array();
			foreach ($allfiles as $value) {
				if(!in_array($value, $currentfiles)){
					$deletearray[] = $value;
				}
			}
			// debugMessage($deletearray);
			if(count($deletearray) > 0){
				foreach ($deletearray as $afile){
					$afile_filename = basename($afile);
					rename($afile, $base.DIRECTORY_SEPARATOR.'archive'.DIRECTORY_SEPARATOR.$afile_filename);
				}
			}
			$this->_helper->redirector->gotoUrl(decode($formvalues['successurl']));
	    	
	    }
		// exit();
	}
}
