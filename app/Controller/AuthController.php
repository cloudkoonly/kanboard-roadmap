<?php

namespace Kanboard\Controller;

use Kanboard\Model\UserModel;

/**
 * Authentication Controller
 *
 * @package  Kanboard\Controller
 * @author   Frederic Guillot
 */
class AuthController extends BaseController
{
    /**
     * Display the form login
     *
     * @access public
     * @param array $values
     * @param array $errors
     */
    public function login(array $values = array(), array $errors = array())
    {
        // koonly code
        if ($this->isLoggedInKoonly()) {
            $user = $this->db
                ->table(UserModel::TABLE)
                ->eq('id', 1)
                ->findOne();
            $this->userSession->initialize($user);
        } // koonly code end
        if ($this->userSession->isLogged()) {
            $this->response->redirect($this->helper->url->to('DashboardController', 'show'));
        } else {
            $this->response->html($this->helper->layout->app('auth/index', array(
                'captcha' => ! empty($values['username']) && $this->userLockingModel->hasCaptcha($values['username']),
                'errors' => $errors,
                'values' => $values,
                'no_layout' => true,
                'title' => t('Login')
            )));
        }
    }

    /**
     * Check credentials
     *
     * @access public
     */
    public function check()
    {
        $values = $this->request->getValues();
        session_set('hasRememberMe', ! empty($values['remember_me']));
        list($valid, $errors) = $this->authValidator->validateForm($values);

        if ($valid) {
            $this->redirectAfterLogin();
        } else {
            $this->login($values, $errors);
        }
    }

    /**
     * Logout and destroy session
     *
     * @access public
     */
    public function logout()
    {
        if (! DISABLE_LOGOUT) {
            $this->sessionManager->close();
            $this->response->redirect($this->helper->url->to('AuthController', 'login'));
        } else {
            $this->response->redirect($this->helper->url->to('DashboardController', 'show'));
        }
    }

    public function isLoggedInKoonly(): bool
    {
        $cid = $_GET['cid']??'';
        $token = $_GET['token']??'';
        if (empty($token)) return false;
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, 'https://www.cloudkoonly.com/api/validateToken');
        curl_setopt($curl, CURLOPT_POST, true);
        $postData = ['cid'=>$cid, 'token' => $token];
        curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($postData));
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        $response = curl_exec($curl);
        curl_close($curl);
        if ($response === false) {
            echo 'cURL error: ' . curl_error($curl);
        } else {
            $result = json_decode($response, true);
            if (isset($result['statusCode']) && $result['statusCode']===200 && isset($result['data']['status']) && $result['data']['status']==='ok') {
                return true;
            }
        }
        return false;
    }
}
