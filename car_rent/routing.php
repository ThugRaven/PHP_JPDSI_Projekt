<?php

use core\App;
use core\Utils;

App::getRouter()->setDefaultRoute('main');
App::getRouter()->setLoginRoute('login');

Utils::addRoute('main', 'MainCtrl');
Utils::addRoute('mainContent', 'MainCtrl');
Utils::addRoute('contact', 'ContactCtrl');

Utils::addRoute('account', 'AccountCtrl', ['customer', 'employee', 'admin']);
Utils::addRoute('accountEdit', 'AccountCtrl', ['customer', 'employee', 'admin']);
Utils::addRoute('accountSave', 'AccountCtrl', ['customer', 'employee', 'admin']);

Utils::addRoute('login', 'LoginCtrl');
Utils::addRoute('logout', 'LoginCtrl');

Utils::addRoute('registration', 'RegisterCtrl');
Utils::addRoute('register', 'RegisterCtrl');

Utils::addRoute('cars', 'CarsCtrl');
Utils::addRoute('carsList', 'CarsCtrl');
Utils::addRoute('car', 'CarsCtrl');

Utils::addRoute('rent', 'RentCtrl', ['customer', 'employee', 'admin']);
Utils::addRoute('rentSummary', 'RentCtrl', ['customer', 'employee', 'admin']);
Utils::addRoute('rentFinal', 'RentCtrl', ['customer', 'employee', 'admin']);

Utils::addRoute('dashboard', 'DashboardCtrl', ['employee', 'admin']);
Utils::addRoute('dashboardMock', 'DashboardMockCtrl', ['admin']);

Utils::addRoute('dashboardRents', 'DashboardRentsCtrl', ['employee', 'admin']);
Utils::addRoute('dashboardRentsList', 'DashboardRentsCtrl', ['employee', 'admin']);
Utils::addRoute('dashboardRentEdit', 'DashboardRentsCtrl', ['employee', 'admin']);
Utils::addRoute('dashboardRentSave', 'DashboardRentsCtrl', ['employee', 'admin']);

Utils::addRoute('dashboardCars', 'DashboardCarsCtrl', ['employee', 'admin']);
Utils::addRoute('dashboardCarsList', 'DashboardCarsCtrl', ['employee', 'admin']);
Utils::addRoute('dashboardCarEdit', 'DashboardCarsCtrl', ['employee', 'admin']);
Utils::addRoute('dashboardCarSave', 'DashboardCarsCtrl', ['employee', 'admin']);
Utils::addRoute('dashboardCarBlock', 'DashboardCarsCtrl', ['employee', 'admin']);

Utils::addRoute('dashboardUsers', 'DashboardUsersCtrl', ['employee', 'admin']);
Utils::addRoute('dashboardUsersList', 'DashboardUsersCtrl', ['employee', 'admin']);
Utils::addRoute('dashboardUserEdit', 'DashboardUsersCtrl', ['employee', 'admin']);
Utils::addRoute('dashboardUserSave', 'DashboardUsersCtrl', ['employee', 'admin']);
