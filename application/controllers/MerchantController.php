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
    	if($action == "addsuccess" || $action == "approve") {
			return ACTION_VIEW; 
		}
		if($action == "delete" ) {
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
}
