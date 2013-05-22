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
    	if($action == "addsuccess" ) {
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

}
