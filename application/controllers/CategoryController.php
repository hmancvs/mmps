<?php

class CategoryController extends SecureController  {
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
    	if($action == "addsuccess") {
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
    
}
