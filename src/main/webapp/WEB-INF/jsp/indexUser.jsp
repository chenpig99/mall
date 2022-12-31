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
<div id="indexUser">
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
                        label="商品名称"
                        prop="name">
                </el-table-column>
                <el-table-column
                        label="分类"
                        prop="category">
                </el-table-column>
                <el-table-column
                        label="分类"
                        prop="category">
                </el-table-column>
                <el-table-column
                    label="单价"
                    prop="price">
            </el-table-column>
                <el-table-column
                        label="库存"
                        prop="inventory">
                </el-table-column>
                <el-table-column
                        align="right">
                    <template slot="header" slot-scope="scope">
                    </template>
                    <template slot-scope="scope">
                        <el-button
                                size="mini"
                                @click="handleEdit(scope.$index, scope.row)">查看详情</el-button>
                        <el-button
                                size="mini"
                                type="danger"
                                @click="handleDelete(scope.$index, scope.row)">购买</el-button>
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
            <span>详情描述：</span>
            <span>{{details}}</span>
            <div class="demo-image__lazy">
                <el-image  :src="pic" lazy></el-image>
            </div>
            <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible = false">取 消</el-button>
    <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
  </span>
        </el-dialog>
        <!-- Form -->
        <el-dialog title="下单" :visible.sync="dialogFormVisible">
            <el-form v-model="quantity">
                <el-form-item label="数量" :label-width="formLabelWidth">
                    <el-input v-model="quantity" autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="purchase()">确 定</el-button>
            </div>
        </el-dialog>
    </el-container>
</div>
</div>

</body>
<script>
    new Vue({
        el: '#indexUser',
        data:{
            id:'',
            currentPage: 1,
            total:'',
            quantity:'',
            dialogVisible: false,
            dialogTableVisible: false,
            dialogFormVisible: false,
            navList:[
                {name:'/indexUser', navItem:'商品首页'},
                {name:'/informationUser',navItem:'我的信息'},
                {name:'/login',navItem:'退出'},
            ],

            details:'',
            tableData: {
                name: '',
                category: '',
                description:'',
                price:'',
                inventory:'',
                pic:''
            },
            pic:'',
            search: ''
        },
        computed: {},
        watch: {},
        created() {
            axios({
                url:'queryCommodity',
                method:'get',
                params:{
                    'currentPage':this.currentPage
                }
            }).then(res=>{
                this.tableData=res.data.records;
                this.total=res.data.total;
                console.log(res.data)
            })
        },
        mounted() {

        },
        methods: {
            jump(item){
              console.log(item)
                window.location.href=item.name;
            },
            /**
             * 查看详情
             * @param index
             * @param row
             */
            handleEdit(index, row) {
                console.log(index, row);
                this.details=row.description
                this.pic=row.picture
                console.log(this.pic)
                this.dialogVisible = true;
            },
            handleDelete(index, row) {
                console.log(index, row);
                this.id=row.id;
                this.dialogFormVisible = true;
            },
            purchase(){
                this.dialogFormVisible = false;
                if(this.quantity==''){
                    this.$alert("购买失败", '提示', {
                        confirmButtonText: '确定',
                        callback: action => {
                            this.$message({
                                type: 'info',
                                message: "非法输入!"
                            });
                        }
                    })
                    return
                }
                axios({
                    url:'purchase',
                    method:'get',
                    params:{
                        'id':this.id,
                        'number':this.quantity
                    }
                }).then(res=>{
                    this.$alert(res.data, '提示', {
                        confirmButtonText: '确定',
                        callback: action => {
                            this.$message({
                                type: 'info',
                                message: res.data
                            });
                        }
                    })
                    this.form.number=this.form.number-this.quantity
                    return
                }).catch(re=>{

                })

            },
            /**
             * 分页
             */
            handleCurrentChange(val) {
                axios({
                    url:'queryCommodity',
                    method:'get',
                    params:{
                        'currentPage':val
                    }
                }).then(res=>{
                    this.tableData=res.data.records;
                    this.total=res.data.total;
                    console.log(res.data)
                })
            }
        }
    });
</script>


</html>
