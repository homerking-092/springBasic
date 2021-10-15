<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
.uploadResult{
		width: 100%;
		background-color: gray;
	}
	.uploadResult ul{
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	.uploadResult ul li{
		list-style: none;		
		padding: 10px;
	}
	.uploadResult ul li img{
		width: 20px;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시물 입력창</h1>
	<form action="/board/register" method="post">
		<input type="text" name="title" placeholder="제목"><br>
		<textarea rows="10" cols="30" name="content" placeholder="내용"></textarea> <br>
		<input type="text" name="writer" placeholder="글쓴이"><br> 
		<input type="submit" id="submitBtn" value="확인">
	<a href="/board/list"><input type="button" value="목록으로"></a>
	</form>
	
	<hr>
	<!-- register.jsp가 폼 업로드 역할을 하고 있음 -->
	<h2>첨부파일</h2>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<div class="uploadResult">
		<ul>
			<!-- 업로드된 파일이 들어갈 자리 -->
		</ul>
	</div>
	
	<button id="uploadBtn">upload</button>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
	// 파일업로드
	$(document).ready(function() {

		// 정규표현식으로 파일 확장자, 용량 거르기
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; // 5MB

		function checkExtension(fileName, fileSize) {
			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}

			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다");
				return false;
			}
			return true;
		}

		// 업로드시 파일 선택을 초기화시키기 위해 미리 업로드되지 않은
		// .uploadDiv를 깊은복사로 복사해둠
		var cloneObj = $(".uploadDiv").clone();
		
		$('#uploadBtn').on("click", function(e) {

			// ajax는 제출버튼을 눌렀을때 목적지가 없기 때문에
			// 빈 폼을 만들고 거기에 정보를 채워나갑니다
			var formData = new FormData();

			var inputFile = $("input[name = 'uploadFile']");
			console.log(inputFile);

			var files = inputFile[0].files;

			console.log(files);

			// 파일 데이터를 폼에 집어넣기
			for (var i = 0; i < files.length; i++) {
				// 폼에 넣기 전에 검사부터
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			console.log(formData);

			// 비동기요청
			$.ajax({
				url : '/uploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				type : 'POST',
				dataType: 'json',	// 입력시 json으로 콘솔에, 안입력하면 xml로 콘솔에 찍힘
				success : function(result) {
					console.log(result);	// 내가 업로드한 파일 내역이 콘솔에 찍히나 디버깅
					// alert("uploaded");
					
					// 업로드된 그림파일 목록을 ul내부에 리스트로 입력
					showUploadedFile(result);
					
					// 세팅되어있던 파일이 업로드되면서 목록에서 사라지게 처리
					$(".uploadDiv").html(cloneObj.html());
				}
			});// $.ajax
		});	// onclick uploadBtn
		
		var uploadResult = $(".uploadResult ul");
		
		function showUploadedFile(uploadResultArr) {
			var str = "";
			
			// i는 인덱스번호(0, 1, 2....) obj 그림파일 정보가 담긴 json
			$(uploadResultArr).each(function (i, obj) {
				
				console.log("------------------");
				console.log(i);
				console.log(obj);
				console.log("-------------------");
				
				if (!obj.image) {
					
					var fileCallPath = encodeURIComponent(
						obj.uploadPath + "/"
					   + obj.uuid + "_" +obj.fileName);
					
					// 그림이 아니면 썸네일대신 resources폴더 내 이미지를 대체로 표시
					str += "<li "
						+ "data-path='" + obj.uploadPath + "'data-uuid= '" + obj.uuid
						+ "' data-filename='" + obj.fileName + "' data-type='" + obj.image
						+ "'><a href='/download?fileName=" + fileCallPath
						+"'><img src = '/resources/attach.png'>"	/// 이미지파일 경로 고정
						+ obj.fileName + "</a>"
						+ "<span data-file=\'" + fileCallPath + "\' data-type='file'> X </span>"
						+ "</li>";
				} else {
					// str += "<li>" + obj.fileName + "</li>";
					// 파일이름 + 썸네일을 보여주기 위해 썸네일 주소 요청하게 만들기
					
					// 수정코드
					/// 섬네일 다운
					var fileCallPath = encodeURIComponent(obj.uploadPath
							+ "/s_" + obj.uuid + "_" + obj.fileName);
					/// 원본 다운
					var fileCallPath2 = encodeURIComponent(obj.uploadPath
							+ "/" + obj.uuid + "_" + obj.fileName);
					
					// 원래 그냥 fileCallPath를 조립해서
					str += "<li "
						+ "data-path='" + obj.uploadPath + "'data-uuid= '" + obj.uuid
						+ "' data-filename='" + obj.fileName + "' data-type='" + obj.image
						+ "'><a href='/download?fileName=" + fileCallPath2
						+"'><img src= '/display?fileName="
						+fileCallPath +"'> " + obj.fileName + "</a>"
						+ "<span data-file=\'" + fileCallPath + "\' data-type='image'> X </span>"
						+ "</li>";
				}
				
			});
			
			uploadResult.append(str);
		}// showUploadedFile
		
		$(".uploadResult").on("click", "span", function (e) {
			
			console.log($(e));
			
			console.log($(this));				
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			console.log(targetFile + "///" + type);
			
			var targetLi = $(this).closest("li");
			console.log(targetLi);
			$.ajax({
				url : '/deleteFile',
				data : {fileName : targetFile, type:type},
				dataType : 'text',
				type : 'POST',
				success : function(result){
					alert(result);
					targetLi.remove();
				}
				
			});	//end $.ajax
		});	// end click span
		
		
		////////////////////////////////////////////////////
		$("#submitBtn").on("click", function (e) {
			// 클릭된 요소의 동작 중지(제출버튼인 경우 버튼을 눌러도 제출이 되지 않음)
			// 글쓰기 했을떄, 그림이 몇장 추가될지는 글을 써봐야 알수 있음
			e.preventDefault();
			
			// 위의 form에 업로드된 그림요소드렝 대한 정보를 추가합니다
			// 1. form 태그 정보 얻어오기
			// 상단 form태그에 이미지 관련 정보를 hidden으로 추가하기 위해 얻어옴
			var formObj = $('form');
			
			// 2. 추가내용을 먼저 받기 위해 빈 문자열 생성
			var str = "";
			
			// 3. uploadResult 내부에 들어간 그림정보를 얻어와서
			// formObj 내부에 넣어주기
			// .iploadResult 내부 ul 내부의 li가 그림정보를 담고 있으므로
			$(".uploadResult ul li").each(function (i, obj) {
				
				var imginfo = $(obj);
				
				// BOardVO 내부의 List<BoardAttachVO>를 처리하기 위해 변수명 attachList로 전달
				str += "<input type='hidden' name='attachList[" + i + "].fileName'"
					+ "value='" + imginfo.data("filename") + "'>"
					+ "<input type='hidden' name='attachList[" + i + "].uuid'"
					+ "value='" + imginfo.data("uuid") + "'>"
					+ "<input type='hidden' name='attachList[" + i + "].uploadPath'"
					+ "value='" + imginfo.data("path") + "'>"
					+ "<input type='hidden' name='attachList[" + i + "].image'"
					+ "value='" + imginfo.data("type") + "'>"
			});
			// 반복이 끝나면, formObj에 위 태그들을 추가한 다음 제출합니다
			formObj.append(str).submit();
			// 그림정보가 잘 추가되는지디버깅
			//console.log($(formObj));
			
			
		}); //end submitBtn
		
		
	
	</script>
	
</body>
</html>