<?php

class SignupController extends IndexController   {	
	
	function processstep1Action() {
		// the group to which the user is to be added
		$formvalues = $this->_getAllParams();
		debugMessage($this->_getAllParams()); // exit();	
		$iscustomer = false;
		$ismerchant = false;
		if($this->_getParam('type') == 2){
			$iscustomer = true;
		}
		if($this->_getParam('type') == 3){
			$ismerchant = true;
		}	
		
		$this->_setParam("isactive", 0); 
		$this->_setParam('entityname', 'UserAccount');
		$this->_setParam(URL_FAILURE, encode($this->view->baseUrl("signup")));
		$this->_setParam(URL_SUCCESS, encode($this->view->baseUrl("signup/confirm")));
		$this->_setParam("action", ACTION_CREATE); 
		$firstname = ucfirst($formvalues['firstname']);
		$lastname = ucfirst($formvalues['lastname']);
		
		// set parent's gender from person type
		$post = array(
			"createdby" => "1",
			"usergroups_groupid" => array($this->_getParam('type')),
			"type" => $this->_getParam('type')
		);
		
		if($ismerchant){
			$thestore = array(); 
			$thestore[0]['name'] = $formvalues['storename'];
			$thestore[0]['username'] = $formvalues['username'];
			$thestore[0]['url'] = $formvalues['url'];
			
			$post['merchant']['type'] = $formvalues['merchanttype'];
			$post['merchant']['category'] = $formvalues['category'];
			if($formvalues['merchanttype'] == 1){
				$post['merchant']['contactperson'] = $firstname.' '.$lastname;
				$post['merchant']['orgname'] = $formvalues['orgname'];
			}
			if($formvalues['merchanttype'] == 2){
				$post['merchant']['firstname'] = $firstname;
				$post['merchant']['lastname'] = $lastname;
			} 
			$post['merchant']['phone'] = str_pad(ltrim($formvalues['phone'], '0'), 12, COUNTRY_CODE_UG, STR_PAD_LEFT);
			$post['merchant']['email'] = $formvalues['email'];
			$post['merchant']['stores'] = $thestore;
		}
		
		$this->_setParam('firstname', $firstname);
		$this->_setParam('lastname', $lastname);
		$this->_setParam('createdby', $post['createdby']);
		$this->_setParam('usergroups_groupid', $post['usergroups_groupid']);
		$this->_setParam('merchant', $post['merchant']);
		
		// debugMessage($this->_getAllParams());
		// exit();
		parent::createAction();
	}
	
	function processinviteAction() {
		$this->_helper->layout->disableLayout();
		$this->_helper->viewRenderer->setNoRender(TRUE);
		
		$formvalues = $this->_getAllParams();
		$session = SessionWrapper::getInstance(); 
		$id = $formvalues['userid'];
		// debugMessage($formvalues);
		
		$user = new UserAccount();
		$user->populate($id);
		// debugMessage($user->toArray());
		$user->setPassword(sha1($formvalues['password']));
		$user->setActivationDate(date('Y-m-d H:i:s'));
		$user->setActivationKey('');
		$user->setIsActive(1);
		$user->setAgreedToTerms(1);
		$user->save();
		
		// exit();
		$this->clearSession();
		$loginurl = $this->view->baseUrl("user/checklogin/email/".$user->getEmail().'/password/'.$formvalues['password']);
		$this->_helper->redirector->gotoUrl($loginurl);
		
		return false;
	}
	
	function activateAction() {
		$session = SessionWrapper::getInstance(); 
		$formvalues = $this->_getAllParams();
		if(!isArrayKeyAnEmptyString('id', $formvalues)){
			// debugMessage($formvalues);
			$isphoneactivation = false;
			if(!isArrayKeyAnEmptyString('act_byphone', $formvalues)){
				// debugMessage('activated via phone');
				$isphoneactivation = true;
			}
			$user = new UserAccount(); 
			$user->populate(decode($formvalues['id']));
			// debugMessage($user->toArray());
			
			if ($user->isUserActive() && isEmptyString($user->getActivationKey())) {
				// account already activated 
	    		$session->setVar(ERROR_MESSAGE, 'Account is already activated. Please login.'); 
				$this->_helper->redirector->gotoUrl($this->view->baseUrl("user/login"));
			}
			
			$this->_setParam(URL_FAILURE, encode($this->view->baseUrl("signup/confirm/id/".encode($user->getID()))));
			$key = $this->_getParam('actkey');
			
			$this->view->result = $user->activateAccount($key, $isphoneactivation);
			// exit();
			if (!$this->view->result) {
				// activation failed
				$this->view->message = $user->getErrorStackAsString();
				$session->setVar(FORM_VALUES, $this->_getAllParams());
	    		$session->setVar(ERROR_MESSAGE, $user->getErrorStackAsString()); 
				$this->_helper->redirector->gotoUrl(decode($this->_getParam(URL_FAILURE)));
			}
		}
	}
	
	function activateaccountAction() {
		$session = SessionWrapper::getInstance(); 
		// replace the decoded id with an undecoded value which will be used during processPost() 
		$id = decode($this->_getParam('id')); 
		$this->_setParam('id', $id); 
		
		$user = new UserAccount(); 
		$user->populate($id);
		$user->processPost($this->_getAllParams());
		
		if ($user->hasError()) {
			$session->setVar(FORM_VALUES, $this->_getAllParams());
    		$session->setVar(ERROR_MESSAGE, $user->getErrorStackAsString()); 
			$this->_helper->redirector->gotoUrl(decode($this->_getParam(URL_FAILURE)));
		}
		
		$result = $user->activateAccount($this->_getParam('activationkey'));
		if ($result) {
			// go to sucess page 
			$this->_helper->redirector->gotoUrl(decode($this->_getParam(URL_SUCCESS))); 
		} else {
			$session->setVar(FORM_VALUES, $this->_getAllParams());
    		$session->setVar(ERROR_MESSAGE, $user->getErrorStackAsString()); 
			$this->_helper->redirector->gotoUrl(decode($this->_getParam(URL_FAILURE)));
		}
	}
	
	function mobileactivateAction() {
		$this->_helper->layout->disableLayout();
		$this->_helper->viewRenderer->setNoRender(TRUE);
		
		$formvalues = $this->_getAllParams();
		// $formvalues['phone'] = '0756412300';
		$session = SessionWrapper::getInstance();
		// debugMessage($formvalues);
		$key = trim($formvalues['actkey']);
		$user = new UserAccount();
		
		$useraccount = $user->populateByPhone(getFullPhone($formvalues['phone']), $key);
		// debugMessage($useraccount->toArray());
		
		# check if user with specified phone exists
		if(!isEmptyString($useraccount->getID())){
			# now validate user's activation code specified
			if($useraccount->getActivationKey() == $key){
				$useraccount->getPhones()->get(0)->setIsPrimary(1);
				$useraccount->getPhones()->get(0)->activate();
				$this->_helper->redirector->gotoUrl($this->view->baseUrl("signup/index/profile/".encode($useraccount->getFarmerID()).'/actkey/valid'));
			} else {
				$this->_helper->redirector->gotoUrl($this->view->baseUrl("signup/activate/acterror/1"));
			}
		} else {
			$this->_helper->redirector->gotoUrl($this->view->baseUrl("signup/activate/acterror/1"));
		}
		// exit();
	}
	
	function confirmAction() {
		
	}
	
	function activationerrorAction() {
		
	}
	
	function activationconfirmationAction() {
		
	}
	
	function inviteconfirmationAction() {
		
	}
	
	function getcaptchaAction(){
		$this->view->layout()->disableLayout();
	    $this->_helper->viewRenderer->setNoRender(true);
		$session = SessionWrapper::getInstance(); 
		
		$string = '';
		for ($i = 0; $i < 5; $i++) {
			$string .= chr(rand(97, 122));
		}
		$session->setVar('random_number', $string);
		// $_SESSION['random_number'] = $string;

		$dir = $this->view->baseUrl("images/fonts/");
		//$dir = APPLICATION_PATH."/../public/images/fonts";
		// debugMessage($dir);
		$image = imagecreatetruecolor(165, 50);

		// random number 1 or 2
		
		echo $session->getVar('random_number');
	}
	function captchaAction() {
		$this->view->layout()->disableLayout();
	    $this->_helper->viewRenderer->setNoRender(true);
		$session = SessionWrapper::getInstance();
		//include('dbcon.php');
		// debugMessage('scre is '.strtolower($this->_getParam('code')));
		// debugMessage('rand is '.strtolower($session->getVar('random_number')));
		if(strtolower($this->_getParam('code')) == strtolower($session->getVar('random_number'))){
			echo 1;// submitted 
		} else {
			echo 0; // invalid code
		}
	}
	
	function testAction() {
		$this->_helper->layout->disableLayout();
	    $this->_helper->viewRenderer->setNoRender(true);
		$user = new UserAccount();
		$user->populate(decode($this->_getParam('id')));
		$user->transactionSave();
		//debugMessage($user->toArray());
		//debugMessage($user->getFarmer()->getNextRegNo());
	}
	
	function checkstoreusernameAction(){
		$this->_helper->layout->disableLayout();
	    $this->_helper->viewRenderer->setNoRender(true);
	    
		$formvalues = $this->_getAllParams();
		$username = trim($formvalues['username']);
		// debugMessage($formvalues);
		$merchant = new Merchant();
		if(!isArrayKeyAnEmptyString('merchantid', $formvalues)){
			$merchant->populate($formvalues['merchantid']);
		}
		if($merchant->usernameExists($username)){
			echo '1';
		} else {
			echo '0';
		}
	}
	
	function checkemailAction(){
		$this->_helper->layout->disableLayout();
	    $this->_helper->viewRenderer->setNoRender(true);
	    
		$formvalues = $this->_getAllParams();
		$email = trim($formvalues['email']);
		// debugMessage($formvalues);
		$user = new UserAccount();
		if(!isArrayKeyAnEmptyString('userid', $formvalues)){
			$user->populate($formvalues['userid']);
		}
		if($user->emailExists($email)){
			echo '1';
		} else {
			echo '0';
		}
	}
	
	function checkphoneAction(){
		$this->_helper->layout->disableLayout();
	    $this->_helper->viewRenderer->setNoRender(true);
	    
		$formvalues = $this->_getAllParams();
		$phone = trim($formvalues['phone']);
		// debugMessage($formvalues);
		$user = new UserAccount();
		if(!isArrayKeyAnEmptyString('userid', $formvalues)){
			$user->populate($formvalues['userid']);
		}
		if($user->phoneExists(getFullPhone($phone))){
			echo '1';
		} else {
			echo '0';
		}
	}
	
	function pricingAction(){
		
	}
}
