<%--
  Created by IntelliJ IDEA.
  User: 1
  Date: 2022/12/30
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册页</title>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>

<style>

</style>
<body>
<div id="register">
    <el-row type="flex" justify="center">
        <el-form ref="formData" :model="formData" :rules="rules" label-width="80px" @keyup.enter.native="register()">
            <el-form-item prop="userName" label="账号"><el-input v-model="formData.account" placeholder="请输入用户账号" prefix-icon="icon-login_user" clearable></el-input></el-form-item>


            <el-form-item prop="cheackPassword" label="姓名"><el-input v-model="formData.name" placeholder="再次输入姓名"  prefix-icon="icon-login_pwd" clearable></el-input></el-form-item>
            </el-form-item>

            <el-form-item prop="sex"  label="性别" >
                <el-radio v-model="formData.sex" label="男">男</el-radio>
                <el-radio v-model="formData.sex" label="女">女</el-radio></el-form-item>
            </el-form-item>
            <el-form-item prop="telephone" label="手机号"><el-input v-model="formData.telephone" ></el-input></el-form-item>
            </el-form-item>
            <el-form-item prop="email" label="邮箱"><el-input v-model="formData.email" ></el-input></el-form-item>
            </el-form-item>
            <el-form-item prop="balance" label="用户类型"><el-radio v-model="formData.type" label="买家" checked>买家</el-radio>
                <el-radio v-model="formData.type" label="卖家">卖家</el-radio></el-form-item></el-form-item>
            </el-form-item>
            <el-form-item prop="password" label="密码"><el-input v-model="formData.password" placeholder="请输入密码" type="password" prefix-icon="icon-login_pwd" clearable></el-input></el-form-item>
            <el-form-item prop="cheackPassword" label="确认密码"><el-input v-model="formData.cheackPassword" placeholder="再次输入密码" type="password" prefix-icon="icon-login_pwd" clearable></el-input></el-form-item>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="register(formData)" icon="el-icon-upload">注册</el-button>
                <el-button @click="resetForm(formData)">重置</el-button></el-form-item>
            <el-link type="primary" @click="index()" >已有账号？登录</el-link>
        </el-form>
    </el-row>
</div>
</div>

</body>
<script>
    new Vue({
        el: '#register',
        data() {
            return {
                formData: {
                    account: '',
                    password: '',
                    cheackPassword:'',
                    name:'',
                    sex:'男',
                    telephone:'',
                    email:'',
                    type:'买家'
                },

            };
        },
        methods: {
            register(formName) {
                if (formName.account==''||formName.password==' '|formName.cheackPassword==' ') {
                    this.$alert('不合法输入', '提示', {
                        confirmButtonText: '确定',
                        callback: action => {
                            this.$message({
                                type: 'info',
                                message: "请检查输入！"
                            });
                        }

                    })
                    return;
                }
                if (formName.password!=formName.cheackPassword){
                    this.$alert('密码不一致！', '提示', {
                        confirmButtonText: '确定',
                        callback: action => {
                            this.$message({
                                type: 'info',
                                message: "2次密码不一致！"
                            });
                        }
                    })
                    return;
                }
                if (formName.type=="买家"){
                    formName.type=1
                }else {
                    formName.type=2
                }

                axios({
                    url:'userRegister',
                    method:'post',
                    data:this.formData
                }).then(res=>{
                    if(res.data==0){
                        this.$alert('注册成功！', '提示', {
                            confirmButtonText: '确定',
                            callback: action => {
                                this.$message({
                                    type: 'info',
                                    message: "注册成功！"
                                });
                            }
                        })
                    }else {
                        this.$alert('注册失败！', '提示', {
                            confirmButtonText: '确定',
                            callback: action => {
                                this.$message({
                                    type: 'info',
                                    message: "已存在账号！！"
                                });
                            }
                        })
                    }
                }).catch(res=>{
                    this.$alert('服务器出错！', '提示', {
                        confirmButtonText: '确定',
                        callback: action => {
                            this.$message({
                                type: 'info',
                                message: "请检查输入是否有误！！"
                            });
                        }
                    })
                })
            },
            //重置表单
            resetForm() {
                this.formData={
                    account: '',
                    password: '',
                    cheackPassword:'',
                    name:'',
                    sex:'男',
                    telephone:'',
                    email:'',
                    type:'买家'
                }

            },
            index(){
                window.location.href="login";
            }

        }
    });
</script>


</html>
