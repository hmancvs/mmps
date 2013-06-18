<?php

class StorecategoryController extends IndexController  {
	
	function viewAction(){
		//$this->_helper->layout->disableLayout();
		// $this->_helper->viewRenderer->setNoRender(TRUE);
		$session = SessionWrapper::getInstance(); 
		$formvalues = $this->_getAllParams();
		// debugMessage($formvalues);
		if(!isEmptyString($this->_getParam('id'))){
			$category = new Category();
			$category->populate(decode($formvalues['id']));
			if(!isEmptyString($category->getID())){
				$store = $category->getStore();
				$this->view->store = $store->getUserName();
				// debugMessage($this->view->store);
			}
		}
	}
}
