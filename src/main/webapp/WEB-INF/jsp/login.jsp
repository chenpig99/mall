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
    <title>登录页</title>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>

<style>
    .login_container{
        background: #2b4b6b;
        height:100%;

    }
    .login_box{
        width: 450px;
        height: 240px;
        background-color: rgba(255, 255, 255, 0.418);
        border-radius:5px;
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%,-50%);
    }
    .login_form{
        position: absolute;
        bottom: 0;
        width: 100%;
        padding: 0 20px;

    box-sizing: border-box;

    }
    .btns{
        display: flex;
        justify-content: center;
    }
</style>
<body>
<div id="app">
        <el-row type="flex" justify="center">
            <el-form  label-width="80px" @keyup.enter.native="login()">
                <el-form-item  label="账号"><el-input v-model="formData.account" placeholder="请输入用户名" prefix-icon="icon-login_user" clearable></el-input></el-form-item>
                <el-form-item  label="密码"><el-input v-model="formData.password" placeholder="请输入密码" type="password" prefix-icon="icon-login_pwd" clearable></el-input></el-form-item>
                </el-form-item>
                <el-form-item><el-button type="primary" class="btn" @click="login()" >登录</el-button>
                    <el-button >重置</el-button></el-form-item></el-form-item>
                <el-link type="primary" @click="register()" target="/register">没有密码？注册</el-link>
            </el-form>
        </el-row>
    </div>
</div>
</body>
<script>
    new Vue({
        el: '#app',
        data:{
                formData: {
                    name: '',
                    password: '',
                },
        },
        computed: {},
        watch: {},
        created() {},
        mounted() {
        },
        methods: {
            //选项卡切换
            handleClick(tab, event) {},
            //重置表单
            resetForm(formName) {
                this.formData={
                    account: '',
                        password: '',
                }
            },
            register(){
                window.location.href="register";
            },
            login(){
                axios({
                    url:'userLogin',
                    method: 'post',
                    data:this.formData
                }).then(res=>{
                    console.log(res)
                    if(res.data==2){
                        this.$alert('密码不正确', '提示', {
                            confirmButtonText: '确定',
                            callback: action => {
                                this.$message({
                                    type: 'info',
                                    message: "密码不正确！"
                                });
                            }
                        })
                        return;
                    }
                    //普通用户
                    if (res.data==1) {
                        window.location.href = "indexUser"
                    }else{
                        window.location.href="admin"
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


            }
        }
    });
</script>


</html>
