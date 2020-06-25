<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.context.annotation.AnnotationConfigApplicationContext" %>
<%@ page import="com.sungjun.web.controller.UserDao" %>
<%@ page import="com.sungjun.web.controller.User" %>
<%@ page import="com.sungjun.web.controller.TableDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: hsj33
  Date: 2020-06-11
  Time: 오후 1:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>

<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <title>Wordbook</title>
  <!-- Favicon-->
  <link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/resources/assets/img/favicon.ico" />
  <!-- Font Awesome icons (free version)-->
  <script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js" crossorigin="anonymous"></script>
  <!-- Google fonts-->
  <link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic" rel="stylesheet" type="text/css" />
  <!-- Third party plugin CSS-->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/magnific-popup.min.css" rel="stylesheet" />
  <!-- Core theme CSS (includes Bootstrap)-->
  <link href="<%=request.getContextPath() %>/resources/css/styles.css" rel="stylesheet" />
  <script src="//code.jquery.com/jquery-1.11.2.min.js"></script>

</head>
<body id="page-top" onload="makeList(), tableBuild()">
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
  <div class="container">
    <a class="navbar-brand js-scroll-trigger" href="#page-top">Wordbook</a><button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav ml-auto my-2 my-lg-0">
        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#about">About</a></li>
        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#services">Services</a></li>
      </ul>
    </div>
  </div>
</nav>
<!-- Masthead-->
<header class="masthead">
  <div class="container h-100">
    <div class="row h-100 align-items-center justify-content-center text-center">
      <div class="col-lg-10 align-self-end">
        <h1 class="text-uppercase text-white font-weight-bold">단어공부를 도와줍니다.</h1>
        <hr class="divider my-4" />
      </div>
      <div class="col-lg-8 align-self-baseline">
        <p class="text-white-75 font-weight-light mb-5">단어가 힘드신 당신을 위하여!</p>
        <a class="btn btn-primary btn-xl js-scroll-trigger" href="#about">Find Out More</a>
      </div>
    </div>
  </div>
</header>
<!-- About-->
<section class="page-section bg-primary" id="about">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-8 text-center">
        <h2 class="text-white mt-0">단어장 만들기</h2>
        <hr class="divider light my-4" />
        <p>엔터키는 뜻 추가</p>
        <p>↓키는 단어 추가</p>
        <p>현재 입력중인 칸은 데이터에 입력되지 않습니다.</p>
        <p>한 줄을 완성시켜야 데이터가 입력됩니다.</p>
        <div class="card" sytle="width:100%;">
          <div class="card-header">

            <select id="tableName" style="float:left;">

            </select>
              <button onclick="reset()" style="float: right">초기화</button>
              <button onclick="dataBuild()" style="float: right">가져오기</button>
              <button onclick="deleteTable()" style="float: right">삭제하기</button>
          </div>
          <div class="card-header">
            <input id="fileinput" accept=".csv" style="float:left;" type="file" onchange="fileBuild(this)">
          </div>
          <div id='wordData'>
            <div class="input-group">
              <div class="input-group-prepend">
                <span class="input-group-text">단어장 이름</span>
              </div>
              <input id="DatatableName" style="width: 80%">
            </div>
            <table id="wordTable">
              <tr>
                <td>단어</td>
                <td colspan="99">뜻</td>
              </tr>

            </table>

            <button style="float: right" class="mt-3" onclick="makeData()">테이블 생성하기</button>
            <script>
                const reader = new FileReader()

                const select = document.getElementById("tableName");
                const table = document.getElementById('wordTable');
                const tableNameInput = document.getElementById("DatatableName");
                var row, cell = null;


                var totalArray = new Array();
                var rowArray = new Array();
                var tableListArray = new Array();
                var ranmdomAry = new Array;
                var wrongAray = new Array;

                var count =0;
                var Anum =0;

                var first = true;

                reader.onload = function (e) {
                    var re = /\r?\n|\r/;
                    var data = e.target.result;
                    data = replaceAll(data, re, "^");
                    var tampArray = data.split("^");
                    for (var i = 0; i < tampArray.length - 1; i++) {
                        rowArray = tampArray[i].split(",");
                        totalArray.push(rowArray);
                    }

                    rowArray = new Array();
                    makeFileTable();
                }

                function reset() {
                    for (var i = 0; i < totalArray.length+1; i++) {
                        table.deleteRow(1);
                    }
                    totalArray = new Array();
                    rowArray = new Array();
                    tableBuild();

                }
                function makeList() {
                    var list = "${tableList}".replace(" ", "").replace("[", "").replace("]", "");
                    tableListArray = list.split(",");
                    var html = "<option value=''>단어장 선택</option>";
                    for (var i = 0; i < tableListArray.length; i++) {
                        html += "<option id='"+tableListArray[i].replace(" ", "")+"' value='" + tableListArray[i].replace(" ", "") + "'>" + tableListArray[i] + "</option>"
                    }
                    select.innerHTML = html;
                }
                function tableBuild() {
                    row = table.insertRow();
                    makeCell(0,0);
                    tableNameInput.focus();
                }

                function fileBuild(sender) {
                    var name = sender.value;
                    name = name.replace("C:\\fakepath\\", "").replace(".csv", "");
                    const csv = sender.files[0]
                    reader.readAsText(csv)
                    tableNameInput.value = name;
                }

                function replaceAll(str, searchStr, replaceStr) {
                    return str.split(searchStr).join(replaceStr);
                }

                function makeCell(i,j) {
                    cell = row.insertCell();
                    cell.innerHTML = "<input onkeydown='makeTable()' type='text' id=" +i + "-" + j + ">";
                    var input =document.getElementById(i + "-" + j)
                    input.focus();
                }

                function makeFileTable() {
                    for (var i = 0; i < totalArray.length; i++) {
                        for (var j = 0; j < totalArray[i].length; j++) {
                            if (totalArray[i][j] != "") {
                                var currentInput = document.getElementById(i + "-" + j);
                                currentInput.value = totalArray[i][j];
                                currentInput.disabled = true;
                                makeCell(i,(j+1));
                            }
                        }
                        row.removeChild(cell);
                        row = table.insertRow();
                        makeCell((i+1),0);
                    }
                }

                function makeTable(i,j) {
                    var currentInput = document.getElementById(totalArray.length + "-" + rowArray.length);
                    var inputData = currentInput.value;
                    if (window.event.keyCode == 13){
                        if(inputData!=""){
                            currentInput.disabled = true;
                            rowArray.push(inputData);
                            makeCell(totalArray.length, rowArray.length)
                        }
                    }
                    else if (window.event.keyCode == 40) {
                        if (inputData != "") {
                            if (rowArray.length >= 1) {
                                currentInput.disabled = true;
                                rowArray.push(inputData);
                                totalArray.push(rowArray);
                                rowArray = new Array();
                                row = table.insertRow();
                                makeCell(totalArray.length,rowArray.length);
                            }
                            else alert("입력이 잘못되었습니다.")
                        }
                        else {
                            if (rowArray.length > 1) {
                                row.removeChild(cell);
                                totalArray.push(rowArray);
                                rowArray = new Array();
                                row = table.insertRow();
                                makeCell(totalArray.length,rowArray.length);
                            }
                            else alert("입력이 잘못되었습니다.")
                        }
                    }
                }

                function changeTable() {
                    $('#myModal').modal("hide");
                    deleteTable();
                    var data = tableNameInput.value;
                    $.ajax({
                        url: "createTable",
                        type: "POST",
                        data: data,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        success: function (data) {
                            if (data) {
                                createJson();
                                alert("데이터 베이스에 테이블을 생성하였습니다.");
                                tableListArray.push(tableNameInput.value);
                                var html = "<option id='"+tableNameInput.value+"' value='" + tableNameInput.value + "'>" + tableNameInput.value + "</option>"
                                select.innerHTML += html;
                            }
                            else alert("같은 이름의 테이블이 이미 존재합니다.");
                        },
                        error: function () {
                            alert("error createTable");
                        }
                    });
                }
                function createJson() {
                    var data = tableNameInput.value;
                    var tampJson = null;
                    var id = 1;
                    for (var i = 0; i < totalArray.length; i++) {
                        for (var j = 1; j < totalArray[i].length; j++) {
                            if (totalArray[i][j] != "") {
                                var tampData = [id, totalArray[i][0], totalArray[i][j]]
                                tampJson = JSON.stringify({
                                    "table": [data],
                                    "data": tampData
                                })
                                id += 1;
                                $.ajax({
                                    url: "createData",
                                    type: "POST",
                                    data: tampJson,
                                    contentType: "application/json; charset=UTF-8",
                                    success: function (data) {
                                    },
                                    error: function () {
                                    }
                                });
                            }
                        }
                    }
                }





                function makeModal() {
                    var modalName = tableNameInput.value + "와 같은 테이블이 존재합니다."
                    var modalLable = document.getElementById("myModalLabel");
                    modalLable.innerHTML = modalName;
                    var clientData = document.getElementById("client");
                    var text = "";
                    for (var i = 0; i < totalArray.length; i++) {
                        text += totalArray[i];
                        text += "<br>";
                    }
                    clientData.innerHTML = text;
                    var tableData = new Array();
                    var data = tableNameInput.value;
                    $.ajax({
                        url: "sendData",
                        type: "POST",
                        data: data,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        success: function (data) {
                            var databaseData = document.getElementById("dataBase");
                            text = "";
                            var tampArray = new Array();
                            for (var i = 0; i < data.length; i++) {
                                if (i > 0) {
                                    if (data[i].word == data[i - 1].word) {
                                        tampArray.push(data[i].mean);
                                    }
                                    else {
                                        tableData.push(tampArray);
                                        tampArray = new Array();
                                        tampArray.push(data[i].word);
                                        tampArray.push(data[i].mean);
                                    }
                                }
                                else {
                                    tampArray.push(data[i].word);
                                    tampArray.push(data[i].mean);
                                }
                            }
                            console.log(tableData);
                        },
                        error: function () {
                            alert("error sendData");
                        }
                    });

                }
                function dataBuild() {
                  var data = select.value;
                  tableNameInput.value =data;
                  $.ajax({
                    url: "sendData",
                    type: "POST",
                    data: data,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    success: function (data) {
                      for(var i=0; i<data.length; i++){
                        var word = data[i].word;
                        var mean = data[i].mean;
                        if(i==0){
                          rowArray.push(word);
                          rowArray.push(mean);
                        }
                        else{
                          if(rowArray[0]==word){
                            rowArray.push(mean);
                          }
                          else{
                            totalArray.push(rowArray);
                            rowArray = new Array();
                            rowArray.push(word);
                            rowArray.push(mean);
                          }
                        }
                      }
                      totalArray.push(rowArray);
                      rowArray = new Array();
                      makeFileTable()
                    },
                    error: function () {
                      alert("error sendData");
                    }
                  });
                }
                function makeData() {
                    //html 테이블에 적힌값을 DataBase에 생성
                    var data = tableNameInput.value;
                    for (var i = 0; i < tableListArray.length; i++) {
                        console.log(data);
                        console.log(tableListArray[i].replace(" ", ""));
                        if (data == tableListArray[i].replace(" ", "")) {
                            $('#myModal').modal('show');
                            makeModal();
                            return;
                        }
                    }
                    if (totalArray.length > 0) {
                        $.ajax({
                            url: "createTable",
                            type: "POST",
                            data: data,
                            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                            success: function (data) {
                                if (data) {
                                    createJson();
                                    alert("데이터 베이스에 테이블을 생성하였습니다.");
                                }
                                else alert("같은 이름의 테이블이 이미 존재합니다.");
                                tableListArray.push(tableNameInput.value);
                                var html = "<option id='"+tableNameInput.value+"' value='" + tableNameInput.value + "'>" + tableNameInput.value + "</option>"
                                select.innerHTML += html;
                            },
                            error: function () {
                                alert("error createTable");
                            }
                        });
                    }
                    else alert("단어를 한줄이상 작성해주세요");
                }


                function deleteTable() {
                    var tableName = select.value;
                    $.ajax({
                        url: "deleteTable",
                        type: "POST",
                        data: tableName,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        success: function (data) {
                            alert("테이블을 삭제하였습니다.");
                            select.removeChild(document.getElementById(tableName))
                          for(var i=0; i<tableListArray.length;i++){
                            if(tableName==tableListArray[i])tableListArray.pop(i);
                          }
                        },
                        error: function () {
                            alert("error deleteTable");
                        }
                    });
                }
                function writeWord(){
                   var tampNum = totalArray[ranmdomAry[count]].length;
                   while(true){
                       Anum = Math.floor(Math.random() * tampNum);
                       if(totalArray[ranmdomAry[count]][Anum]!="") break;
                   }
                   var viewWord = document.getElementById("viewWord");
                   viewWord.innerHTML = totalArray[ranmdomAry[count]][Anum];
                }

                function makeCard(bool) {
                    var a= "<div class='card'>";
                    var b= "<div class='card-body' id='word' style='text-align: center'>";
                    var d= "</div></div>";
                    if(bool){
                        var c= "맞았습니다."
                        $('#textArea').append(a+b+c+d);
                    }
                    else{
                        if(Anum==0){
                            var c= totalArray[ranmdomAry[count]][0]+"<br>"
                            var c_1= totalArray[ranmdomAry[count]][1];
                            $('#textArea').append(a+b+c+c_1+d);
                        }
                        else{
                            var c= totalArray[ranmdomAry[count]][0]+"<br>"
                            var c_1= totalArray[ranmdomAry[count]][Anum];
                            $('#textArea').append(a+b+c+c_1+d);
                        }

                    }
                }
                function randomNumber(){
                    ranmdomAry = new Array;
                    for(var i=0; i<totalArray.length; i++){
                        var randNum = Math.floor(Math.random() * totalArray.length);
                        ranmdomAry[i]=randNum;
                        for(var j=0; j<ranmdomAry.length-1; j++){
                            if(ranmdomAry[j]==randNum){
                                i -= 1;
                                break;
                            }
                        }
                    }
                }
                function enterkey() {
                    if (window.event.keyCode == 13) {
                        var inputText = document.getElementById('inputText');
                        var text = inputText.value;
                        inputText.value = "";
                        if(first){
                            randomNumber();
                            var textArea = document.getElementById("textArea");
                            textArea.innerHTML = "";
                            first=false;
                        }
                        else{
                            if(Anum ==0){
                                var tampControl = true;
                                for(var i=1; i<totalArray[ranmdomAry[count]].length; i++){
                                    if(text==totalArray[ranmdomAry[count]][i]){
                                        makeCard(true);
                                        tampControl = false;
                                        break;
                                    }

                                }
                                if(tampControl) makeCard(false);
                            }
                            else{
                                if(text==totalArray[ranmdomAry[count]][0]) makeCard(true);
                                else makeCard(false);
                            }
                            count +=1;
                            if(count == ranmdomAry.length){
                                var viewWord = document.getElementById("viewWord");
                                viewWord.innerHTML = "문제를 모두 푸셨습니다.<br> 다시하고 싶으시면 엔터키를 눌러주세요";
                                count=0;
                                first = true;
                                return;
                            }
                        }
                        writeWord();
                    }
                }
            </script>
          </div>
        </div>
        <p class="text-white-50 mb-4"></p>
        <a class="btn btn-light btn-xl js-scroll-trigger" href="#services">Get Started!</a>
      </div>
    </div>
  </div>
</section>
<!-- Services-->
<section class="page-section" id="services">
  <div class="container">
    <h2 class="text-center mt-0">서비스 이용</h2>
    <hr class="divider my-4" />
    <div>
      <div class="card">
        <div class="card-body" id="viewWord" style="text-align: center">
          시작하시려면 단어를 등록하시고 enter키를 누르세요
        </div>
      </div>
      <div class="input-group mb-3">
        <input type="text" class="form-control" id = "inputText" onkeyup="enterkey();" placeholder="" aria-label="Recipient's username" aria-describedby="basic-addon2">
      </div>
    </div>

    <div >
      <div id="textArea" style="display: flex; flex-flow: wrap;">
      </div>
        <button>csv파일 만들기</button>
        <button>데이터 파일 만들기</button>
    </div>
  </div>
</section>

<!-- Footer-->
<footer class="bg-light py-5">
  <div class="container"><div class="small text-center text-muted">Copyright © 2020 - Start Bootstrap</div></div>
</footer>

<!-- 모달 영역 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 style="color:red;" class="modal-title" id="myModalLabel">모달 타이틀</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
              <h1>저장된 내용</h1>
                <div id ="dataBase">

                </div>
                <hr width="100%">
              <h1>변경할 내용</h1>
                <div id ="client">

                </div>
            </div>
            <div class="modal-footer">
              <p style="float:left;">원하시는 버튼을 클릭해주세요</p>
                <button type="button" onclick="changeTable()">업데이트</button>
                <button type="button" onclick="changeTable()">테이블 교체</button>
                <button type="button" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>


<!-- Bootstrap core JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
<!-- Third party plugin JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/jquery.magnific-popup.min.js"></script>
<!-- Core theme JS-->
<script src="<%=request.getContextPath() %>/resources/js/scripts.js"></script>
</body>
</html>
