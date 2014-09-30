"""
Each file that starts with test... in this directory is scanned for subclasses of unittest.TestCase or testLib.RestTestCase
"""

import unittest
import os
import testLib


class TestAddUser(testLib.RestTestCase):

    """Test destroying users table records"""
    def testDestroy(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'kevin_casey', 'password' : 'is_amazing!'} )
        self.assertEquals(1, respData['count'])

        self.makeRequest("/TESTAPI/resetFixture", method="POST", data = {} )

        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'kevin_casey', 'password' : 'is_amazing!'} )
        self.assertEquals(-1, respData['errCode'])

        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'kevin_casey', 'password' : 'is_amazing!'} )
        self.assertEquals(1, respData['count'])

    """Test adding users"""
    def testAddEmptyUser(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : '', 'password' : 'password'} )
        self.assertEquals(-3, respData['errCode'])

    def testAddLongUser(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'usernameijofwjoefjwifowjfowjiefojowejfoiwejiofjwoiafjwejfowajfwalfwaifjwlijefilwjfiawjijflwjffwefwefwefweafwefwefwafeawefawefafw9', 'password' : 'password'} )
        self.assertEquals(-3, respData['errCode'])

    """Test logging in users"""
    def testLogin1(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'carina', 'password' : 'password'} )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'carina', 'password' : 'password'} )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'carina', 'password' : 'password'} )
        self.assertEquals(3, respData['count'])

    def testLoginWrongUser(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'carina', 'password' : 'password'} )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'wrongcarina', 'password' : 'password'} )
        self.assertEquals(-1, respData['errCode'])

    def testLoginWrongPassword(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'carina', 'password' : 'password'} )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'carina', 'wrongpassword' : 'password'} )
        self.assertEquals(-1, respData['errCode'])

    
