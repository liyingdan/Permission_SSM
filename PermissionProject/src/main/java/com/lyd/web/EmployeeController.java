package com.lyd.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lyd.domain.AjaxRes;
import com.lyd.domain.Employee;
import com.lyd.domain.PageListRes;
import com.lyd.domain.QueryVo;
import com.lyd.service.EmployeeService;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.util.IOUtils;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
public class EmployeeController {
    /*注入业务层 */
    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("/employee")
    @RequiresPermissions("employee:index")
    public String employee(){
        return "employee";
    }

    /*查询全部员工*/
    @RequestMapping("/employeeList")
    @ResponseBody
    public PageListRes employeeList(QueryVo vo){
        /*调用业务层*/
        PageListRes pageListRes = employeeService.getEmployee(vo);
        return pageListRes;
    }

    /*接收员工 添加表单*/
    @RequestMapping("/saveEmployee")
    @ResponseBody
    @RequiresPermissions("employee:add")
    public AjaxRes saveEmployee(Employee employee){
        AjaxRes ajaxRes = new AjaxRes();
        try{
            employee.setState(true);
            employeeService.insertEmployee(employee);
            ajaxRes.setSuccess(true);
            ajaxRes.setMsg("保存成功");
        }catch (Exception e){
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("保存失败");

        }
        return ajaxRes;
    }

    /*更新员工*/
    @RequestMapping("/updateEmployee")
    @ResponseBody
    @RequiresPermissions("employee:edit")
    public AjaxRes updateEmployee(Employee employee){
        AjaxRes ajaxRes = new AjaxRes();
        try{
            employeeService.updateEmployee(employee);
            ajaxRes.setSuccess(true);
            ajaxRes.setMsg("更新成功");
        }catch (Exception e){
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("更新失败");

        }
        return ajaxRes;
    }

    /*接收离职操作请求*/
    @RequestMapping("/updateState")
    @ResponseBody
    @RequiresPermissions("employee:delete")
    public AjaxRes updateState(Long id){
        AjaxRes ajaxRes = new AjaxRes();
        try{
             employeeService.updateState(id);
            ajaxRes.setSuccess(true);
            ajaxRes.setMsg("更新成功");
        }catch (Exception e){
            System.out.println(e);
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("更新失败");

        }
        return ajaxRes;
    }


    /*异常处理方法*/
    @ExceptionHandler(AuthorizationException.class)
    public void handleShiroException(HandlerMethod method, HttpServletResponse response) throws Exception { /*method是发生异常的方法*/
        /*跳转到一个界面 界面提示没有权限*/
        /*判断 当前的请求是不是json请求  如果是 返回json给浏览器 让它自己来做跳转*/

        /*获取方法上的注解*/
        ResponseBody methodAnnotation = method.getMethodAnnotation(ResponseBody.class);
        if(methodAnnotation != null){
            //ajax
            AjaxRes ajaxRes = new AjaxRes();
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("您没有权限操作呢");
            /*把对象转成json格式字符串*/
            String jsonString = new ObjectMapper().writeValueAsString(ajaxRes);
            response.setCharacterEncoding("utf-8");
            response.getWriter().print(jsonString);

        }else{
            response.sendRedirect("nopermission.jsp");
        }

    }


    /*Excel下载*/
    @RequestMapping("downloadExcel")
    @ResponseBody
    public void downloadExcel(HttpServletResponse response){
        try {
            /*1.从数据库当中获取列表数据*/
            List<Employee> employees=  employeeService.getAllEmployee();

            /*2.创建Excel 写到excel当中*/
            HSSFWorkbook wb = new HSSFWorkbook();
            HSSFSheet sheet = wb.createSheet("员工数据");
            //创建一行
            HSSFRow row = sheet.createRow(0);
            //设置行的每一列的数据
            row.createCell(0).setCellValue("编号");
            row.createCell(1).setCellValue("用户名");
            row.createCell(2).setCellValue("入职日期");
            row.createCell(3).setCellValue("电话");
            row.createCell(4).setCellValue("邮箱");

            HSSFRow employeeRow = null;
            //取出每一个员工去设置数据
            for(int i=0; i<employees.size(); i++){
                Employee employee = employees.get(i);
                employeeRow = sheet.createRow(i+1);
                employeeRow.createCell(0).setCellValue(employee.getId());
                employeeRow.createCell(1).setCellValue(employee.getUsername());
                if(employee.getInputtime() != null){
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    String format = sdf.format(employee.getInputtime());
                    employeeRow.createCell(2).setCellValue(format);
                }else {
                    employeeRow.createCell(2).setCellValue("");
                }
                employeeRow.createCell(3).setCellValue(employee.getTel());
                employeeRow.createCell(4).setCellValue(employee.getEmail());

            }

            /*3.响应给浏览器*/
            String fileName = new String("员工数据.xls".getBytes("utf-8"), "iso8859-1");
            response.setHeader("content-Disposition","attachment;filename="+fileName);
            wb.write(response.getOutputStream());

        } catch (Exception e) {
            e.printStackTrace();
        }


    }


    /*下载模板*/
    @RequestMapping("downloadExcelTml")
    @ResponseBody
    public void downloadExcelTml(HttpServletRequest request ,HttpServletResponse response){
        FileInputStream is = null;
        try {
            String fileName = new String("EmployeeTpl.xls".getBytes("utf-8"), "iso8859-1");
            response.setHeader("content-Disposition","attachment;filename="+fileName);
            //获取文件路径
            String realPath = request.getSession().getServletContext().getRealPath("static/ExcelTml.xls");
            is = new FileInputStream(realPath);
            IOUtils.copy(is,response.getOutputStream());

        }catch (Exception e){
            e.printStackTrace();
        }
        finally {
            if(is != null){
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /*Excel上传*/
    /*配置文件上传解析器 mvc配置当中*/
    @RequestMapping("uploadExcelFile")
    @ResponseBody
    public AjaxRes uploadExcelFile(MultipartFile excel){
        AjaxRes ajaxRes = new AjaxRes();
        try{
            ajaxRes.setMsg("导入成功");
            ajaxRes.setSuccess(true);

            HSSFWorkbook wb = new HSSFWorkbook(excel.getInputStream());
            HSSFSheet sheet = wb.getSheetAt(0);
            //获取最大的行号
            int lastRowNum = sheet.getLastRowNum();
            Row employeeRow = null;
            for(int i=1; i<=lastRowNum; i++){
                employeeRow = sheet.getRow(i);
                Employee employee = new Employee();
                employeeRow.getCell(0);
//                employee.setId((Long)employeeRow.getCell(0));
//                employee.setUsername((String)(employeeRow.getCell(1)));
/*                System.out.println(getCellValue(employeeRow.getCell(0))+"\t");
                System.out.println(getCellValue(employeeRow.getCell(1))+"\t");
                System.out.println(getCellValue(employeeRow.getCell(2))+"\t");
                System.out.println(getCellValue(employeeRow.getCell(3))+"\t");
                System.out.println(getCellValue(employeeRow.getCell(4))+"\t");*/

            }
        }catch (Exception e){
            e.printStackTrace();
            ajaxRes.setMsg("导入失败");;
            ajaxRes.setSuccess(false);
        }
        return ajaxRes;

    }

    private Object getCellValue(Cell cell){
        switch (cell.getCellType()) {
            case STRING:
                return cell.getRichStringCellValue().getString();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return cell.getDateCellValue();
                } else {
                    return cell.getNumericCellValue();
                }
            case BOOLEAN:
                return cell.getBooleanCellValue();
            case FORMULA:
                return cell.getCellFormula();
        }
        return cell;

    }

}
