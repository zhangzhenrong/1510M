<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path=request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/easyui/themes/icon.css">
	<script type="text/javascript" src="<%=path%>/easyui/jquery-1.8.2.js"></script>
	<script type="text/javascript" src="<%=path%>/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=path%>/easyui/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
<div id="cc" class="easyui-layout" style="width:100%;" fit="true">   
    <div data-options="region:'north',title:'North Title',split:true" style="height:100px;"></div>   
    <div data-options="region:'west',title:'West',split:true" style="width:100px;"></div>   
    <div data-options="region:'center',title:'center title'" style="padding:5px;background:#eee;">
         <table id="udg"></table>    
    </div>   
    </div>
<div id="udlg" class="easyui-dialog" closed="true" style="width:350px;height:300px;padding:30px 60px;" data-options="iconCls:'icon-save',minimizable:true,maximizable:true,resizable:true,modal:true">
    <form id="ufrm" method="post">
   		<div style="margin-bottom:20px">
   			<label for="name">用户：</label>
   			<input class="easyui-textbox" type="text" name="name" data-options="required:true" /> 
   		</div>
   		<div style="margin-bottom:20px">
   			<label for="age">年龄</label>
   			<input class="easyui-textbox" type="text" name="age" data-options="required:true" />
   		</div>
   		<div style="margin-bottom:20px">
   			<label for="sex">性别</label>
   			<input class="easyui-radio" value="0" type="radio" name="sex" data-options="required:true" />男
   			<input class="easyui-radio" value="1" type="radio" name="sex" data-options="required:true" />女
   		</div>
   		<div align="center">
   			<a id="savebtn" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>
   			<a id="resetbtn" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-no'">关闭</a>
   		</div>
   </form>
</div>  

</body>
<script type="text/javascript">
	$("#udg").datagrid({
		 url:'<%=path%>/listUsers',
		  fit:true,
		  fitColumns:true,
		  pagination:true,
		  pageSize:5,
		  pageList:[5,10,15,20],
		  columns:[[
			  {field:'id',title:'编号',width:'20%'},
			  {field:'name',title:'名称',width:'20%'},
			  {field:'age',title:'年龄',width:'10%'},
			  {field:'sex',title:'性别',width:'10%',formatter:function(value){
				  if(value=='1'){
					  return "<font color='red'>女</font>";
				  }else{
					  return "<font color='blue'>男</font>";
				  }
			  }}
		  ]],
		  
		  //新增页面
		  toolbar:[{
			  iconCls:'icon-add',
			  text:'新增',
			  handler:function(){
				  $("#udlg").dialog("setTitle","新增用户").dialog("open");
			  }
		  },'-',{
		  	iconCls:'icon-edit',
		  	text:"编辑",
		  	handler:function(){
		  		var grid=$("#udg").datagrid("getSelections");
		  		console.info(grid);
		  	}
		  },'-',{
			  iconCls:'icon-cut',
			  text:"删除",
			  handler:function(){
				  $.messager.confirm('确认','你确认要删除记录吗',function(r){
					  if(r){
						  $.messager.alert('提示',"删除成功");
					  }
				  });
			  }
		  }
		  ] 
	  });
	//新增用户
	$("#savebtn").click(function(){
		$.post('<%=path%>/addUsers',$("#ufrm").serialize(),function(data){
			if(data>0){
				$.messager.alert("信息","新增成功");
				//弹出窗口关闭
				$("#udlg").dialog("close");
				//列表刷新
				$("#udg").datagrid("load");
			}
		});
	})
</script>
</html>