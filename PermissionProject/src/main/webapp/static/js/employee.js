$(function () {
    /*显示员工表格数据*/
    $("#dg").datagrid({
        url: "/employeeList",
        columns: [[
            {field: 'username', title: '姓名', width: 100, align: 'center'},
            {field: 'inputtime', title: '入职时间', width: 100, align: 'center'},
            {field: 'tel', title: '电话', width: 100, align: 'center'},
            {field: 'email', title: '邮箱', width: 100, align: 'center'},
            {
                field: 'department', title: '部门', width: 100, align: 'center', formatter: function (value, row, index) {
                    if (value) {
                        return value.name;
                    }
                }
            },
            {
                field: 'state', title: '状态', width: 100, align: 'center', formatter: function (value, row, index) {
                    if (row.state) {
                        return "在职";
                    } else {
                        return "<font style='color: red'>离职</font>"
                    }
                }
            },
            {
                field: 'admin', title: '管理员', width: 100, align: 'center', formatter: function (value, row, index) {
                    if (row.admin) {
                        return "是";
                    } else {
                        return "否"
                    }
                }
            },
        ]],
        fit: true,
        fitColumns: true,
        rownumbers: true,
        pagination: true,
        /*只能选中一条会数据*/
        singleSelect: true,
        /*斑马线*/
        striped: true,
        toolbar: "#tb",
        onClickRow: function (rowIndex, rowData) {
            /*判断当前行是否是离职状态*/
            if (!rowData.state) {
                /*离职，把离职按钮禁用*/
                $("#delete").linkbutton("disable");
            } else {
                /*在职，启用离职按钮*/
                $("#delete").linkbutton("enable");
            }
        }

    });

    /*对话框*/
    $("#dialog").dialog({
        width: 300,
        height: 400,
        closed: true,
        buttons: [{
            text: '保存',
            handler: function () {
                /*判断当前是添加 还是编辑*/
                var id = $("[name='id']").val();
                var url;
                if (id) {
                    /*编辑*/
                    url = "updateEmployee";
                } else {
                    /*添加*/
                    url = "saveEmployee";
                }
                /*提交表单*/
                $("#employeeForm").form("submit", {
                    url: url, /*表单发送地址*/
                    onSubmit: function (param) {
                        /*获取选中的角色*/
                        var values = $("#role").combobox("getValues");
                        for (var i = 0; i < values.length; i++) {
                            var rid = values[i];
                            param["roles[" + i + "].rid"] = rid;
                        }
                    },
                    success: function (data) {/*提交返回的信息*/
                        data = $.parseJSON(data);
                        /*解析成json*/
                        if (data.success) {
                            $.messager.alert("温馨提示：", data.msg);
                            /*关闭对话框*/
                            $("#dialog").dialog("close");
                            /*重新加载表格*/
                            $("#dg").datagrid("reload");
                        } else {
                            $.messager.alert("温馨提示：", data.msg);
                        }
                    }
                });
            }
        }, {
            text: '关闭',
            handler: function () {
                $("#dialog").dialog("close");
            }
        }]
    });

    /*监听添加按钮*/
    $("#add").click(function () {
        /*清空表单数据*/
        $("#employeeForm").form("clear");
        $("#dialog").dialog("open");
        $("#dialog").dialog("setTitle", "添加员工");
        $("#password").show();
        /*添加密码的验证*/
        $("[name='password']").validatebox({required: true});

    });

    /*监听编辑按钮点击*/
    $("#edit").click(function () {
        /*清空表单数据*/
        $("#employeeForm").form("clear");
        /*获取当前选中的行*/
        var rowData = $("#dg").datagrid("getSelected");
        if (!rowData) {
            $.messager.alert("提示", "选择一行数据进行编辑");
            return;
        }
        /*取消密码的验证 以为jsp中添加了密码不能为空的验证，
        如果不取消就提交不了表单。同时在添加选项中打开*/
        $("[name='password']").validatebox({required: false});
        /*弹出对话框*/
        $("#dialog").dialog("open");
        /*设置标题*/
        $("#dialog").dialog("setTitle", "编辑员工");
        /*隐藏密码栏*/
        $("#password").hide();
        /*由于是同名匹配的原则，而回显的数据中对象只有department而没有department.id，需要单独设置*/
        rowData["department.id"] = rowData["department"].id;
        /*回显管理员*/
        rowData["admin"] = rowData["admin"] + "";
        /*回显角色*/
        /*根据当前用户的id，查出对应的角色*/
        $.get("/getRoleByEid?id=" + rowData.id, function (data) {
            /*设置下拉列表数据回显*/
            $("#role").combobox("setValues", data);
        })
        /*选中数据的回显 */
        $("#employeeForm").form("load", rowData);

    });

    /*部门选择*/
    $("#department").combobox({
        width: 150,
        panelHeight: 'auto',
        editable: false,
        url: 'departmentList',
        textField: 'name',
        valueField: 'id',
        onLoadSuccess: function () {/*数据加载完毕后回调*/
            /*在刷新的时候input里面的placeholder就会不在  需要重新设置*/
            $("#department").each(function (i) {
                var span = $(this).siblings("span")[i];
                var targetInput = $(span).find("input:first");
                if (targetInput) {
                    $(targetInput).attr("placeholder", $(this).attr("placeholder"));
                }
            });

        }
    });

    /*是否为管理员*/
    $("#admin").combobox({
        width: 150,
        panelHeight: 'auto',
        textField: 'label',
        valueField: 'value',
        editable: false, /*不允许修改框中的内容*/
        data: [{
            label: '是',
            value: 'true'
        }, {
            label: '否',
            value: 'false'
        }],
        onLoadSuccess: function () {/*数据加载完毕后回调*/
            /*在刷新的时候input里面的placeholder就会不在  需要重新设置*/
            $("#admin").each(function (i) {
                var span = $(this).siblings("span")[i];
                var targetInput = $(span).find("input:first");
                if (targetInput) {
                    $(targetInput).attr("placeholder", $(this).attr("placeholder"));
                }
            });

        }
    });

    /*选择角色*/
    $("#role").combobox({
        width: 150,
        panelHeight: 'auto',
        editable: false,
        url: 'roleList',
        textField: 'rname',
        valueField: 'rid',
        multiple: true, /*可选多个值*/
        onLoadSuccess: function () {/*数据加载完毕后回调*/
            /*在刷新的时候input里面的placeholder就会不在  需要重新设置*/
            $("#role").each(function (i) {
                var span = $(this).siblings("span")[i];
                var targetInput = $(span).find("input:first");
                if (targetInput) {
                    $(targetInput).attr("placeholder", $(this).attr("placeholder"));
                }
            });

        }
    })


    /*设置离职按钮点击*/
    $("#delete").click(function () {
        /*获取当前选中的行*/
        var rowData = $("#dg").datagrid("getSelected");
        console.log(rowData);
        if (!rowData) {
            $.messager.alert("提示", "选择一行数据进行编辑");
            return;
        }
        /*提醒用户，是否做离职操作*/
        $.messager.confirm("确认", "是否做离职操作", function (res) {
            if (res) {
                /*做离职操作*/
                $.get("/updateState?id=" + rowData.id, function (data) {
                    /*使用get发送请求会自动解析成json格式，不用在自己设置了*/
                    if (data.success) {
                        $.messager.alert("温馨提示：", data.msg);
                        /*重新加载表格*/
                        $("#dg").datagrid("reload");
                    } else {
                        $.messager.alert("温馨提示：", data.msg);
                    }
                })
            }
        })


    });


    /*监听搜索框点击*/
    $("#searchbtn").click(function () {
        /*获取表单内容*/
        var keyWord = $("[name=keyword]").val();
        /*重新加载数据，并添加参数*/
        $("#dg").datagrid("load", {keyword: keyWord});
    });

    /*点击刷新框的点击*/
    $("#reload").click(function () {
        /*清空搜索框内容*/
        var keyWord = $("[name=keyword]").val('');
        /*重新加载数据*/
        $("#dg").datagrid("load", {});

    });

    /*excelOut按钮监听*/
    $("#excelOut").click(function () {
        window.open('/downloadExcel');
    });

    /*上传框*/
    $("#excelUpload").dialog({
        width: 260,
        height: 180,
        title: "导入Excel",
        buttons: [{
            text: '上传',
            handler: function () {
                $("#uploadForm").form("submit",{
                    url:"uploadExcelFile",
                    success:function (data) {
                        data = $.parseJSON(data); /*解析成json*/
                        if (data.success) {
                            $.messager.alert("温馨提示：", data.msg);
                            $("#excelUpload").dialog("close"); /*关闭对话框*/
                            $("#dg").datagrid("reload"); /*重新加载表格*/
                        } else {
                            $.messager.alert("温馨提示：", data.msg);
                        }
                    }
                });
            }
        }, {
            text: '关闭',
            handler: function () {
                $("#excelUpload").dialog("close");
            }
        }], closed: true
    })

    $("#excelImpot").click(function () {
        $("#excelUpload").dialog("open");
    });

    /*Excel导入*/
    $("#excelIn").click(function () {
        $("#excelUpload").dialog("open");
    });

    /*下载Excel模板*/
    $("#downloadTml").click(function () {
        window.open('/downloadExcelTml');

    });


});