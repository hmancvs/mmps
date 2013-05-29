<?php

class TestController extends IndexController  {
	
    function smsAction(){
    	// disable rendering of the view and layout so that we can just echo the AJAX output 
	    $this->_helper->layout->disableLayout();
	    $this->_helper->viewRenderer->setNoRender(TRUE);
	    
	    $session = SessionWrapper::getInstance(); 
	    $formvalues = $this->_getAllParams();
	    // debugMessage($formvalues);
	    $phone = SMS_TEST_NUMBER;
	    $username = SMS_USERNAME;
	    $password = SMS_PASSWORD;
	    // $port = SMS_PORT;
	    $message = 'helloworld. this is a dev test from farmis '.date('Y-m-d H:i:s');
	    
	    $client = new Zend_Http_Client(SMS_SERVER);
	    // the GET Parameters
		$client->setParameterGet(array(
			'username'  => $username,
			'password'  => $password,
			'type'	=>	0,
			'dlr'	=>	0,
			'source'=>	'TBD',
			'destination' => $phone,
			'message' => $message
		));
		
		// debugMessage($client); // exit();
    	try {
    	    $response = $client->request();
    	    $body = $response->getBody();
    	    // debugMessage($body);
    	    
	    } catch (Exception $e) {
	        # error handling
	        debugMessage("Error is ".$e->getMessage());
	    }
    }
    
    function testmailAction(){
    	$this->_helper->layout->disableLayout();
	    $this->_helper->viewRenderer->setNoRender(TRUE);
	    
    	sendTestMessage('hman test','farmis email testing');
    }
    
    function merchantAction(){
    	$this->_helper->layout->disableLayout();
	    $this->_helper->viewRenderer->setNoRender(TRUE);
	    
	    $session = SessionWrapper::getInstance(); 
	    $formvalues = $this->_getAllParams();
	    $testdata = array(
	    	"createdby" => 1,
		    "type" => 1,
		    "category" => 2,
		    "storename" => "jimstore",
		    "username" => "jimmos",
		    "url" => "http://127.0.0.1/mmps/public/store/jimmos",
		    "orgname" => "Bimbos",
		    "contactperson" => "Nuimber Olka",
		    "phone" => 256703595279,
		    "email" => "test4@devmail.infomacorp.com",
		    "createstore" => 1,
		    "isapproved" => 1,
		    "createuser" => 1,
		    "createuserandinvite" => 1,
		    "stores" => array
		        (
		            "0" => array
		                (
		                    "createdby" => 1,
		                    "name" => "jimstore",
		                    "username" => "jimmos",
		                    "url" => "http://127.0.0.1/mmps/public/store/jimmos"
		                )
		
		        ),
		
		    "status" => 1,
		    "dateapproved" => "2013-05-26 18:00:54",
		    "approvedbyid" => 1,
		    "admins" => array
		        (
		            "0" => array
		                (
		                    "createdby" => 1,
		                    "firstname" => "Nuimber Olka",
		                    "lastname" => ".",
		                    "email" => "test4@devmail.infomacorp.com",
		                    "phone" => 256703595279,
		                    "type" => 3,
		                    "isactive" => 0,
		                    "agreedtoterms" => 0,
		                    "usergroups" => array
		                        (
		                            "0" => array
		                                (
		                                    "groupid" => 3
		                                )
		
		                        ),
		                    "isinvited" => 1,
		                    "invitedbyid" => 1,
		                    "dateinvited" => "2013-05-26"
		                )
		
		        )
	    );
	    
	    $merchant = new Merchant();
	    $merchant->processPost($testdata);
	    debugMessage($merchant->toArray());
	   	debugMessage('error is '.$merchant->getErrorStackAsString());
	    try {
	    	$merchant->save();
	    } catch (Exception $e) {
	    	debugMessage('errors '.$e->getMessage());
	    	debugMessage('error is '.$merchant->getErrorStackAsString());
	    }
	    exit();
    }
    
	function emailAction(){
    	$this->_helper->layout->disableLayout();
	    $this->_helper->viewRenderer->setNoRender(TRUE);
	    
	    sendTestMessage('test farmis email','this is a test message for farmis please ignore - '.APPLICATION_ENV);
    }
}

