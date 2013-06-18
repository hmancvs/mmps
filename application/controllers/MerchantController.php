<?php

class MerchantController extends SecureController  {
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
    	if($action == "addsuccess" || $action == "approve" || $action == "settings" || $action == 'picture') {
			return ACTION_VIEW; 
		}
		if($action == "delete") {
			return ACTION_DELETE; 
		}
		return parent::getActionforACL(); 
    }
    
	public function getResourceForACL(){
        return "User Account"; 
    }
    
	public function addAction(){}
	
	public function approveAction() {
    	$session = SessionWrapper::getInstance(); 
    	$this->_helper->layout->disableLayout();
		$this->_helper->viewRenderer->setNoRender(TRUE);
		
		$formvalues = $this->_getAllParams();
		$successurl = decode($formvalues['successurl']);
		// debugMessage($successurl);
		
		$merchant = new Merchant();
		$merchant->populate(decode($formvalues['id']));
		// debugMessage($merchant->toArray());
    	
    	if($merchant->approve($formvalues['status'])) {
    		$session->setVar(SUCCESS_MESSAGE, $this->_translate->translate("global_approve_success").". An email has been sent to the store admin to activate their account.");
    	} else {
    		$session->setVar(ERROR_MESSAGE, 'An error occured in updating status. '.$session->getVar(ERROR_MESSAGE));
    	}
    	// exit();
    	$this->_helper->redirector->gotoUrl($successurl);
    	
    	return false;
    }
    
	public function settingsAction() {
    	$session = SessionWrapper::getInstance(); 
    	$this->_helper->layout->disableLayout();
		$this->_helper->viewRenderer->setNoRender(TRUE);
		
		$formvalues = $this->_getAllParams();
		$successurl = decode($formvalues['successurl']);
		debugMessage($formvalues);
		
		$store = new Store();
		$store->populate($formvalues['storeid']);
		// debugMessage($store->toArray()); exit();
		switch ($formvalues['field']) {
			case 'logotype':
				$store->setLogoType($formvalues['value']);
				break;
			case 'theme':
				$store->settheme($formvalues['value']);
				break;
			case 'menuconfig':
				$store->setmenuconfig($formvalues['value']);
				break;
			case 'frontconfig':
				$store->setfrontconfig($formvalues['value']);
				break;
			default:
				break;
		}
    	
		try {
			$store->save();
			$session->setVar(SUCCESS_MESSAGE, $this->_translate->translate("global_save_success"));
		} catch (Exception $e) {
			$session->setVar(ERROR_MESSAGE, 'An error occured in updating store settings. '.$session->getVar(ERROR_MESSAGE));
		}
    	
    	$this->_helper->redirector->gotoUrl($successurl);
    	
    	return false;
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
	    $type = $formvalues['type'];
	    // debugMessage($formvalues);
	    $islogo = false;
	    $folder = '';
	    if($type == 1){
	    	$islogo = true;
	    	$folder = 'logo';
	    } 
	    $iscover = false;
	    if($type == 2){
	    	$iscover = true;
	    	$folder = 'cover';
	    } 
	    
		$store = new Store();
		$store->populate(decode($this->_getParam('id')));
		// debugMessage($store->toArray()); 
		
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
			$destination_path = APPLICATION_PATH.DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."public".DIRECTORY_SEPARATOR."uploads".DIRECTORY_SEPARATOR."stores".DIRECTORY_SEPARATOR."store_".$store->getID();
			// create store folder if doesnt exist
	    	if(!is_dir($destination_path)){
				mkdir($destination_path, 0755);
			}
			$destination_path = $destination_path.DIRECTORY_SEPARATOR.$folder;
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
			
			$oldfilename = $store->getLogo();
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
				if($islogo){
					resizeImage($basefile, $destination_path.DIRECTORY_SEPARATOR.'large_'.$currenttime.'.jpg', 300);
					resizeImage($basefile, $destination_path.DIRECTORY_SEPARATOR.'logo_'.$currenttime.'.jpg', 150);
				}
				if($iscover){
					resizeImage($basefile, $destination_path.DIRECTORY_SEPARATOR.'large_'.$currenttime.'.jpg', 450);
					resizeImage($basefile, $destination_path.DIRECTORY_SEPARATOR.'cover_'.$currenttime.'.jpg', 700);
				}
				// unlink($thefilename);
				unlink($destination_path.DIRECTORY_SEPARATOR.'base_'.$currenttime.'.jpg');
				
				// exit();
				// update the useraccount with the new profile images
				try {
					if($islogo){
						$store->setLogo($currenttime.'.jpg');
					}
					if($iscover){
						$store->setCover($currenttime.'.jpg');
					}
					$store->save();
					
					// check if user already has profile picture and archive it
					if($islogo){
						$ftimestamp = current(explode('.', $store->getLogo()));
					}
					if($iscover){
						$ftimestamp = current(explode('.', $store->getCover()));
					}
					
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
	    	if($islogo){
				$oldfile = "large_".$store->getLogo();
	    	}
	    	if($iscover){
	    		$oldfile = "large_".$store->getCover();
	    	}
			$base = APPLICATION_PATH.DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."public".DIRECTORY_SEPARATOR."uploads".DIRECTORY_SEPARATOR."stores".DIRECTORY_SEPARATOR."store_";
			$base = $base.$store->getID().DIRECTORY_SEPARATOR.$folder.DIRECTORY_SEPARATOR;
			// debugMessage($store->toArray()); 
			$src = $base.$oldfile;
			
			$currenttime = mktime();
			$currenttime_file = $currenttime.'.jpg';
			$newlargefilename = $base."large_".$currenttime_file;
			$newmediumfilename = $base.$folder."_".$currenttime_file;
			
			// exit();
			$image = WideImage::load($src);
			if($islogo){
				$cropped1 = $image->crop($formvalues['x1'], $formvalues['y1'], $formvalues['w'], $formvalues['h']);
				$resized_1 = $cropped1->resize(300, 140, 'fill');
				$resized_1->saveToFile($newlargefilename);
				
				//$image2 = WideImage::load($src);
				$cropped2 = $image->crop($formvalues['x1'], $formvalues['y1'], $formvalues['w'], $formvalues['h']);
				$resized_2 = $cropped2->resize(150, 70, 'fill');
				$resized_2->saveToFile($newmediumfilename);
				
				$store->setLogo($currenttime_file);
			}
			if($iscover){
				$cropped1 = $image->crop($formvalues['x1'], $formvalues['y1'], $formvalues['w'], $formvalues['h']);
				$resized_1 = $cropped1->resize(700, 280, 'fill');
				$resized_1->saveToFile($newlargefilename);
				
				//$image2 = WideImage::load($src);
				$cropped2 = $image->crop($formvalues['x1'], $formvalues['y1'], $formvalues['w'], $formvalues['h']);
				$resized_2 = $cropped2->resize(700, 280, 'fill');
				$resized_2->saveToFile($newmediumfilename);
				
				$store->setCover($currenttime_file);
			}
			
			$store->save();
				
			// check if user already has profile picture and archive it
			if($islogo){
				$ftimestamp = current(explode('.', $store->getLogo()));
			}
			if($iscover){
				$ftimestamp = current(explode('.', $store->getCover()));
			}
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
	}
}
