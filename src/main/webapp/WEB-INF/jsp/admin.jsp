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
    <title>卖家(管理页)</title>
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
<div id="admin">
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
        <el-main><template>
            <el-table
                    :data=tableData
                    style="width: 100%">
                <el-table-column
                        label="用户名称"
                        prop="name">
                </el-table-column>
                <el-table-column
                        label="性别"
                        prop="sex">
                </el-table-column>
                <el-table-column
                        label="电话"
                        prop="telephone">
                </el-table-column>
                <el-table-column
                        label="邮箱"
                        prop="email">
                </el-table-column>
                <el-table-column
                        label="余额"
                        prop="balance">
                </el-table-column>
                <el-table-column
                        align="right">
                    <template slot-scope="scope">
                        <el-button
                                size="mini"
                                @click="handleEdit(scope.$index, scope.row)">修改</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </template>
        </el-main>
        <el-footer>  <div class="block">
            <el-pagination
                    @size-change="handleSizeChange"
                    @current-change="handleCurrentChange"
                    :current-page.sync="currentPage"
                    :page-size="10"
                    layout="prev, pager, next, jumper"
                    :total="total">
            </el-pagination>
        </div></el-footer>
        <el-dialog
                title="提示"
                :visible.sync="dialogVisible"
                width="30%"
                :before-close="handleClose">
            <el-form  :model="user" label-width="80px">
                <el-form-item label="用户">
                    <el-input v-model="user.name"></el-input>
                </el-form-item>
                <el-form-item label="性别">
                    <el-select v-model="user.sex" placeholder="请选择活动区域">
                        <el-option label="男" value="男"></el-option>
                        <el-option label="女" value="女"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="电话">
                    <el-input v-model="user.telephone"></el-input>
                </el-form-item>
                <el-form-item label="邮箱">
                    <el-input v-model="user.email"></el-input>
                </el-form-item>
                <el-form-item label="余额">
                    <el-input v-model="user.balance"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
    <el-button @click="res()">取 消</el-button>
    <el-button type="primary" @click="editUser()">确 定</el-button>
  </span>
        </el-dialog>
    </el-container>
</div>
</div>

</body>
<script>
    new Vue({
        el: '#admin',
        data:{
            id:'',
            dialogVisible: false,
            currentPage: 1,
            user:'',
            total:'',
            quantity:'',

            dialogTableVisible: false,
            dialogFormVisible: false,
            navList:[
                {name:'/admin', navItem:'用户列表'},
                {name:'/releaseGoods',navItem:'发布商品'},
                {name:'/orderList',navItem:'订单列表'},
                {name:'/login',navItem:'退出'},
            ],

            tableData: {
                name: '',
                sex: '',
                telephone:'',
                email:'',
                balance:'',

            },
            search: ''
        },
        computed: {},
        watch: {},
        created() {
            axios({
                url:'queryBuyer',
                method:'get',
                params:{
                    'current':this.currentPage
                }
            }).then(res=>{
                this.tableData=res.data.records;
                this.total=res.data.total;
                console.log(res.data)
            })
        },
        methods: {
            jump(item) {
                console.log(item)
                window.location.href = item.name;
            },
            /**
             * 编辑
             * @param index
             * @param row
             */
            handleEdit(index, row) {
                console.log(index, row);
                this.details = row.description
                this.dialogVisible = true;
                this.user = row
            },
            handleClose(done) {
                this.$confirm('确认关闭？')
                    .then(_ => {
                        done();
                    })
                    .catch(_ => {
                    });
                axios({
                    url: 'queryBuyer',
                    method: 'get',
                    params: {
                        'current': this.currentPage
                    }
                }).then(res => {
                    this.tableData = res.data.records;
                    this.total = res.data.total;
                    console.log(res.data)
                })
            },
            /**
             * 分页
             */
            handleCurrentChange(val) {
                axios({
                    url: 'queryBuyer',
                    method: 'get',
                    params: {
                        'current': val
                    }
                }).then(res => {
                    this.tableData = res.data.records;
                    this.total = res.data.total;
                    console.log(res.data)
                })
            },
            res() {
                this.dialogVisible = false
                axios({
                    url:'queryBuyer',
                    method:'get',
                    params:{
                        'current':this.currentPage
                    }
                }).then(res=>{
                    this.tableData=res.data.records;
                    this.total=res.data.total;
                    console.log(res.data)
                })
            },
            editUser() {
                axios({
                    url: 'updateUser',
                    method: 'post',
                    data: this.user
                }).then(res => {
                    this.$alert("修改成功!", '提示', {
                        confirmButtonText: '确定',
                        callback: action => {
                            this.$message({
                                type: 'info',
                                message: "成功!!"
                            });
                        }
                    })
                    this.dialogVisible = false
                }).catch(res => {
                    this.$alert("修改失败", '提示', {
                        confirmButtonText: '确定',
                        callback: action => {
                            this.$message({
                                type: 'info',
                                message: "系统出错!"
                            });
                        }
                    })
                })
            }
        }
    });
</script>


</html>
