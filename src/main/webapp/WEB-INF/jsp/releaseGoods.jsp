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
    <title>卖家(发布商品页)</title>
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
<div id="releaseGoods">
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
                <el-form-item label="商品名称">
                    <el-input v-model="form.name"></el-input>
                </el-form-item>
                <el-form-item label="商品分类">
                    <el-select v-model="form.category" placeholder="请选择商品类别">
                            <el-option label="马列主义" value="马列主义"></el-option>
                        <el-option label="毛泽东思想" value="毛泽东思想"></el-option>
                        <el-option label="哲学" value="哲学"></el-option>
                        <el-option label="社会科学" value="社会科学"></el-option>
                        <el-option label="自然科学" value="自然科学"></el-option>
                        <el-option label="综合性图书" value="综合性图书"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="商品价格">
                    <el-input v-model="form.price"></el-input>
                </el-form-item>
                <el-form-item label="商品库存">
                    <el-input v-model="form.inventory"></el-input>
                </el-form-item>
                <el-form-item label="商品描述">
                    <el-input type="textarea" v-model="form.description"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="onSubmit">立即发布</el-button>
                    <el-button @click="rest">重置</el-button>
                </el-form-item>
            </el-form>
        </el-main>


    </el-container>
</div>
</div>

</body>
<script>
    new Vue({
        el: '#releaseGoods',
        data:{
            navList:[
                {name:'/admin', navItem:'用户列表'},
                {name:'/releaseGoods',navItem:'发布商品'},
                {name:'/orderList',navItem:'订单列表'},
                {name:'/login',navItem:'退出'},
            ],
            form: {
                name: '',
                category:'马列主义',
                description: '',
                price: '',
                inventory: '',
            }
        },
        methods: {
            jump(item){
                console.log(item)
                window.location.href=item.name;
            },
            rest(){
                this.form= {
                    name: '',
                    category:'马列主义',
                    description: '',
                    price: '',
                    inventory: '',
                }
            },
            onSubmit() {
                if (this.form.name=='' ||this.form.category==' '||this.form.description==' '||this.price==' '||this.form.inventory==' '){
                    this.$alert('请检查输入是否合法！', '提示', {
                        confirmButtonText: '确定',
                        callback: action => {
                            this.$message({
                                type: 'info',
                                message: "请检查输入是否有误！！"
                            });
                        }
                    })
                    return;
                }
                axios({
                    url:'releaseCommodity',
                    method:'post',
                    data: this.form
                }).then(res=>{
                    this.$alert('发布成功！', '提示', {
                        confirmButtonText: '确定',
                        callback: action => {
                            this.$message({
                                type: 'info',
                                message: "商品信息发布成功！！"
                            });
                        }
                    })
                    //重置表单
                    this.rest()
                }).catch(res=>{
                    this.$alert('发布失败！', '提示', {
                        confirmButtonText: '确定',
                        callback: action => {
                            this.$message({
                                type: 'info',
                                message: "服务器出错！"
                            });
                        }
                    })
                })
            }
        }
    });
</script>


</html>
