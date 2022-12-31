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
        <el-main>
            <el-table
                    :data="tableData"
                    border
                    style="width: 100%">
                <el-table-column
                        prop="name"
                        label="姓名"
                        >
                </el-table-column>
                <el-table-column
                        prop="sex"
                        label="性别"
                      >
                </el-table-column>
                <el-table-column
                        prop="telephone"
                        label="电话"
                        >
                </el-table-column>
                <el-table-column
                        prop="balance"
                        label="余额"
                        >
                </el-table-column>
                <el-table-column
                        fixed="right"
                        label="操作"
                        width="100">
                    <template slot-scope="scope">
                        <el-button @click="handleClick(scope.row)" type="text" size="small">编辑</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-main>


    </el-container>
</div>
</div>

</body>
<script>
    new Vue({
        el: '#admin',
        data:{
            currentPage: 1,
            total:'',
            navList:[
                {name:'/indexUser', navItem:'商品首页'},
                {name:'/informationUser',navItem:'我的信息'},
            ],
            tableData: {
                name: '',
                sex: '',
                telephone:'',
                email:'',
                balance:'',

            }
        },
        computed: {},
        watch: {},
        created() {
            axios({
                url:'queryLoginUser',
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
                this.dialogVisible = true;
            },
            handleClick(row) {
                console.log(row);
            },


        }
    });
</script>


</html>
