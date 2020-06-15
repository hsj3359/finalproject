<%--
  Created by IntelliJ IDEA.
  User: hsj33
  Date: 2020-06-11
  Time: 오후 1:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <title>Wordbook</title>
  <!-- Favicon-->
  <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/img/favicon.ico" />
  <!-- Font Awesome icons (free version)-->
  <script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js" crossorigin="anonymous"></script>
  <!-- Google fonts-->
  <link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic" rel="stylesheet" type="text/css" />
  <!-- Third party plugin CSS-->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/magnific-popup.min.css" rel="stylesheet" />
  <!-- Core theme CSS (includes Bootstrap)-->
  <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
</head>
<body id="page-top">
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
  <div class="container">
    <a class="navbar-brand js-scroll-trigger" href="#page-top">Wordbook</a><button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav ml-auto my-2 my-lg-0">
        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#about">About</a></li>
        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#services">Services</a></li>
        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#portfolio">Portfolio</a></li>

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
        <div class="card" sytle="width:100%;">
          <div class="card-header">
            <input id="fileinput" style="float:left;" type="file"><button onclick="fileBuild()" style="float: right">만들기</button>
          </div>
          <div id='word'>
            <table id="wordTable" onkeydown="makeTable()"  >

            </table>
            <script>
              var table = document.getElementById('wordTable');
              var row = null;
              var cell = null;
              var num =0;
              var total = new Array();
              var tampArray = new Array();
              var count =0;

                function build() {
                  row = table.insertRow();
                  cell = row.insertCell();
                  cell.innerHTML = "단어";
                  cell = row.insertCell();
                  cell.setAttribute('colspan','99');
                  cell.innerHTML = "뜻";
                  row = table.insertRow();
                  cell = row.insertCell();
                  cell.innerHTML = "<input type='text' id="+num+">";
                  num += 1;
                }
                build()

              function makeCell(currentCell) {
                currentCell.disabled = true;
                tampArray.push(currentCell.value);
                cell = row.insertCell();
                cell.innerHTML = "<input type='text' id="+num+">";
                document.getElementById(num).focus();
                num+=1;
              }
              function fileBuild() {

              }
               function makeTable(){
                 var currentCell = document.getElementById(num-1);
                 if (window.event.keyCode == 13){
                   if(currentCell.value!='')makeCell(currentCell);
                   else window.alert("칸이 비어있습니다.");
                 }
                 else if(window.event.keyCode == 40){
                   var currentCell = document.getElementById(num-1);
                   if(currentCell.value!='') makeCell(currentCell);
                   if(tampArray.length > 1){
                     total.push(tampArray);
                     tampArray = new Array();
                     //삭제
                     row.removeChild(cell);
                     row = table.insertRow();
                     cell = row.insertCell();
                     cell.innerHTML = "<input type='text' id="+num+">";
                     document.getElementById(num).focus();
                     num += 1;
                   }
                   else{
                     window.alert("입력이 잘못되었습니다.");
                   }

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
        <div class="card-body" id="word" style="text-align: center">
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
    </div>
    <script>

    </script>
  </div>
</section>

<!-- Footer-->
<footer class="bg-light py-5">
  <div class="container"><div class="small text-center text-muted">Copyright © 2020 - Start Bootstrap</div></div>
</footer>
<!-- Bootstrap core JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
<!-- Third party plugin JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/jquery.magnific-popup.min.js"></script>
<!-- Core theme JS-->
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
</body>
</html>
