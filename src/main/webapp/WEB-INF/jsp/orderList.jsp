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
<div id="orderList">
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
      <template>
        <el-table
                :data="form"
                border
                style="width: 100%">
          <el-table-column
                  prop="coName"
                  label="名称">

          </el-table-column>
          <el-table-column
                  prop="name"
                  label="买家姓名"
                  >
          </el-table-column>
          <el-table-column
                  prop="amount"
                  label="总金额">
          </el-table-column>
          <el-table-column
                  prop="commodityNumber"
                  label="数量">
          </el-table-column>
          <el-table-column
                  prop="createTime"
                  label="日期">
          </el-table-column>
          <el-table-column
                  prop="telephone"
                  label="买家手机号">
          </el-table-column>
          <el-table-column
                  prop="email"
                  label="邮箱">
          </el-table-column>
        </el-table>
      </template>
    </el-main>
    <el-footer>
      <el-pagination
              @size-change="handleSizeChange"
              @current-change="handleCurrentChange"
              :current-page.sync="current"
              :page-size="100"
              layout="prev, pager, next, jumper"
              :total="1000">
      </el-pagination>
    </el-footer>
  </el-container>
</div>
</div>
</body>
<script>
  new Vue({
    el: '#orderList',
    data:{
      current:'1',
      navList:[
        {name:'/admin', navItem:'用户列表'},
        {name:'/releaseGoods',navItem:'发布商品'},
        {name:'/orderList',navItem:'订单列表'},
        {name:'/login',navItem:'退出'},
      ],
      form: {
        coName:'',
        name:'',
        email:'',
        telephone:'',
        amount:'',
        commodityNumber:'',
        createTime:''
      }
    },
    created() {
      axios({
        url:'orderPage',
        method:'get',
        params: {
          'current':this.current}
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
      handleSizeChange(val) {
        console.log(`每页 ${val} 条`);
      },
      handleCurrentChange(val) {
        axios({
          url:'orderPage',
          method:'get',
          params: {
            'current':val}
        }).then(res=>{
          this.form=res.data;
          console.log(this.form)
        })
      },


    }

  });
</script>


</html>
