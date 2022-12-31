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
    <title>个人信息</title>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>

<style>
    .el-menu-item{
        font-size: 18px !important;
    }
    .el-menu-item.is-active {
        color: #ea5b2c !important;
        font-size: 18px !important;
    }
    .el-menu--horizontal>.el-menu-item.is-active {
        border-bottom: 2px solid #ea5b2c !important;
    }
    .el-header {
        display: flex;
        width: 100%;
    }

</style>
<body>
<div id="information">
    <el-container>
        <el-header >
            <el-menu
                    class="el-menu-demo"
                    mode="horizontal"
                    @select="handleSelect"
                    router
                    background-color="#fff"
                    text-color="#333"
                    active-text-color="#0084ff"
                    style="flex:1"
            >
                <el-menu-item v-for="(item, i) in navList" >
                            <span>
                                  <el-button @click="jump(item)">{{ item.navItem }}</el-button>
                            </span>
                </el-menu-item>
            </el-menu>
        </el-header>
        <el-main>
            <el-form ref="form" :model="form" label-width="80px">
                <el-form-item label="账号">
                    <span>{{form.account}}</span>
                </el-form-item>
                <el-form-item label="用户名">
                    <el-input v-model="form.name"></el-input>
                </el-form-item>
                <el-form-item label="性别">
                    <el-radio-group v-model="form.sex">
                        <el-radio label="男"></el-radio>
                        <el-radio label="女"></el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="手机号">
                    <el-input v-model="form.telephone"></el-input>
                </el-form-item>
                <el-form-item label="邮箱">
                    <el-input v-model="form.email"></el-input>
                </el-form-item>
                <el-form-item label="余额">
                    <span >{{form.balance}}</span>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="onSubmit">更新个人信息</el-button>
                    <el-button type="primary" @click="dialogFormVisible = true">充值余额</el-button>
                </el-form-item>
            </el-form>
        </el-main>
        <!-- Form -->
        <el-dialog title="输入要充值的余额" :visible.sync="dialogFormVisible">
            <el-form :model="form">
                <el-form-item label="充值:" :label-width="formLabelWidth">
                    <el-input v-model="form.money" autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="topUp()">确 定</el-button>
            </div>
        </el-dialog>
    </el-container>
</div>
</div>

</body>
<script>
    new Vue({
        el: '#information',
        data:{

            formLabelWidth: '120px',
            dialogFormVisible: false,
            navList:[
                {name:'/indexUser', navItem:'商品首页'},
                {name:'/informationUser',navItem:'我的信息'},
                {name:'/login',navItem:'退出'},
            ],
            form: {
                account:'',
                name:'',
                sex:'',
                telephone:'',
                email:'',
                balance:'',
                money:'',
            }
        },
        computed: {},
        watch: {},
        created() {
            axios({
                url:'queryLoginUser',
                method:'get',
            }).then(res=>{
                this.form=res.data;
                console.log(this.form)
            })
        },
        mounted() {

        },
        methods: {
            jump(item){
                console.log(item)
                if(item.name=='/login'){
                    axios({
                        url:'exit',
                        method:'get'
                    })
                }
                window.location.href=item.name;
            },
            topUp(){
                this.dialogFormVisible = false
                axios({
                    url:'topUp',
                    method:'post',
                    data:this.form
                }).then(res=>{
                    this.$alert('成功', '提示', {
                        confirmButtonText: '确定',
                        callback: action => {
                            this.$message({
                                type: 'info',
                                message: "充值成功！"
                            });
                        }
                    })
                    this.form.money=''
                    this.form.balance=res.data;
                }).catch(res=>{
                    this.$alert('失败', '提示', {
                        confirmButtonText: '确定',
                        callback: action => {
                            this.$message({
                                type: 'info',
                                message: "充值失败！服务器错误!检查输入!"
                            });
                        }
                    })
                    this.form.money=''
                })
            },
            onSubmit() {
                axios({
                    url:'updateInformation',
                    method: 'post',
                    data:this.form
                }).then(res=>{
                    if (res.data==0){
                        this.$alert("成功!", '提示', {
                            confirmButtonText: '确定',
                            callback: action => {
                                this.$message({
                                    type: 'info',
                                    message: "修改成功!"
                                });
                            }
                        })
                    }else {
                        this.$alert("失败", '提示', {
                            confirmButtonText: '确定',
                            callback: action => {
                                this.$message({
                                    type: 'info',
                                    message:"修改失败!"
                                });
                            }
                        })
                    }
                }).catch(res=>{
                    this.$alert("失败", '提示', {
                        confirmButtonText: '确定',
                        callback: action => {
                            this.$message({
                                type: 'info',
                                message:"服务器异常!"
                            });
                        }
                    })
                })
            }
            }

    });
</script>


</html>
