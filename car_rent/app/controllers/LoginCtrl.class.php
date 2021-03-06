<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use app\transfer\User;
use app\forms\LoginForm;
use core\DBUtils;

class LoginCtrl {

    private $form;

    public function __construct() {
        $this->form = new LoginForm();
    }

    public function getParams() {
        $this->form->login = ParamUtils::getFromRequest('login');
        $this->form->password = ParamUtils::getFromRequest('password');
    }

    public function validate() {
        if (!(isset($this->form->login) && isset($this->form->password))) {
            return false;
        }
        if (SessionUtils::loadObject('user', true) !== null) {
            Utils::addErrorMessage('Jesteś już zalogowany');
            return false;
        }

        if (!App::getMessages()->isError()) {
            if ($this->form->login == '') {
                Utils::addErrorMessage('Nie podano loginu');
            }
            if ($this->form->password == '') {
                Utils::addErrorMessage('Nie podano hasła');
            }
        }

        if (!App::getMessages()->isError()) {
            $hashed_pwd = DBUtils::get('user', null, 'password', [
                        'login' => $this->form->login
            ]);

            if (password_verify($this->form->password, $hashed_pwd)) {
                $role = DBUtils::get('user', [
                            '[><]user_role' => 'id_user_role'
                                ], 'user_role.role_name', [
                            'login' => $this->form->login
                ]);

                $user = new User($this->form->login, $role);
                SessionUtils::storeObject('user', $user);
                RoleUtils::addRole($role);
            } else {
                Utils::addErrorMessage('Niepoprawny login lub hasło!');
            }
        }

        return !App::getMessages()->isError();
    }

    public function action_login() {
        $this->getParams();
        App::getSmarty()->assign('page_title', "Logowanie");

        if ($this->validate()) {
            App::getRouter()->redirectTo('main');
        } else {
            $this->generateView();
        }
    }

    public function action_logout() {
        session_unset();
        session_destroy();

        App::getRouter()->redirectTo('main');
    }

    public function generateView() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));

        App::getSmarty()->display('LoginView.tpl');
    }

}
