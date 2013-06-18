<?php

class StoreController extends IndexController  {
	
	function viewAction(){
		$session = SessionWrapper::getInstance(); 
		$formvalues = $this->_getAllParams();
		// debugMessage($formvalues);
		
		if(!isEmptyString($this->_getParam('username'))){
			$this->view->store = $formvalues['username'];
			$session->setVar('store', $formvalues['username']);
		}
	}
	
	function categoryAction(){
		$session = SessionWrapper::getInstance(); 
		$formvalues = $this->_getAllParams();
		debugMessage($formvalues);
		
	}

	function productAction(){
		$session = SessionWrapper::getInstance(); 
		$formvalues = $this->_getAllParams();
		// debugMessage($formvalues);
		
		if(!isEmptyString($this->_getParam('id'))){
			$product = new Product();
			$product->populate(decode($formvalues['id']));
			if(!isEmptyString($product->getID())){
				$store = $product->getStore();
				$this->view->store = $store->getUserName();
				// debugMessage($this->view->store);
			}
		}
		
	}
	
	function productsAction(){
		$session = SessionWrapper::getInstance(); 
		$formvalues = $this->_getAllParams();
		// debugMessage($formvalues);
		
		if(!isEmptyString($this->_getParam('id'))){
			$store = new Store();
			$storeid = decode($formvalues['id']);
			$store->populate($storeid);
			if(!isEmptyString($store->getID())){
				$this->view->store = $store->getUserName();
				// debugMessage($this->view->store);
			}
		}
		// exit();
	}
	
	function cartAction(){
		$session = SessionWrapper::getInstance(); 
		$formvalues = $this->_getAllParams();
		// debugMessage($formvalues);
		$action = $this->_getParam('step');
		
		if(!isEmptyString($this->_getParam('id'))){
			$store = new Store();
			$storeid = decode($formvalues['id']);
			$store->populate($storeid);
			if(!isEmptyString($store->getID())){
				$this->view->store = $store->getUserName();
				// debugMessage($this->view->store);
			}
		}
		
		$item = array(); 
		$cart = $session->getVar('cart'); 
		if(!isEmptyString($this->_getParam('pid'))){
			$productid = decode($formvalues['pid']);
			$product = new Product();
			$product->populate($productid);
			$pname = $product->getName();
			
			if (!is_array($cart)) {
				// there is no cart in session
				$cart = array(); 
			}
			if(isEmptyString($this->_getParam('qty'))){
				$this->_setParam('qty', 1);
			}
			$qty = $this->_getParam('qty');
			// $qty = 2;
			// add a new item to the cart
			$item[$productid] = array('pid' => $productid, 'qty' => $qty, 'name' => $pname);
			// debugMessage($item);
			// no of items in cart before adding new
			$cartcount = count($cart);
			
			//check if the item already exists in cart
			$exists = false;
			if(in_array($item[$productid], $cart) && count($cart) > 0){
				// debugMessage('exists');
				$exists = true;
				$prevqty = '';
			} else {
				// debugMessage('new');
				$prevqty = 1;
				$cart[$productid] = $item[$productid];
			}
			// $session->setVar('cart', array());
			foreach($cart as $key => $cartitem){
				if($key == $productid){
					if($item[$productid]['qty'] == 1){
						$msg = '<b>'.$pname.'</b> successfully added to your Shopping Cart';
					} else {
						$msg = '<b>'.$qty.'</b> items of <b>'.$pname.'</b> successfully added to your Shopping Cart';
					}
					// debugMessage('>> '.$item[$productid]['qty'].' and '.$prevqty);
					if($item[$productid]['qty'] != $prevqty && !isEmptyString($prevqty)){
						// debugMessage('diff');
						$session->setVar(SUCCESS_MESSAGE, $msg);
					}
					
					$cart[$key]['qty'] = $item[$productid]['qty'];
				} 
				// removing item from cart
				if($this->_getParam('step') == 'del'){
					unset($cart[$productid]);
					$msg = '<b>'.$pname.'</b> successfully removed from your Cart';
					$session->setVar(SUCCESS_MESSAGE, $msg);
				}
			}
		}
		// removing all items from cart
		if($this->_getParam('step') == 'reset'){
			$cart = array(); 
		}
		
		$session->setVar('cart', $cart);
		$this->view->cart = $session->getVar('cart');
		// debugMessage($session->getVar('cart')); // exit();
	}
	
	function watchlistAction(){
		$session = SessionWrapper::getInstance(); 
		$formvalues = $this->_getAllParams();
		// debugMessage($formvalues);
		
		if(!isEmptyString($this->_getParam('id'))){
			$store = new Store();
			$storeid = decode($formvalues['id']);
			$store->populate($storeid);
			if(!isEmptyString($store->getID())){
				$this->view->store = $store->getUserName();
				// debugMessage($this->view->store);
			}
		}
	}
	
	function checkoutAction(){
		$session = SessionWrapper::getInstance(); 
		$formvalues = $this->_getAllParams();
		// debugMessage($formvalues);
		
		if(!isEmptyString($this->_getParam('id'))){
			$store = new Store();
			$store->populate(decode($formvalues['id']));
			if(!isEmptyString($store->getID())){
				$this->view->store = $store->getUserName();
				// debugMessage($this->view->store);
			}
		}
	}
}
