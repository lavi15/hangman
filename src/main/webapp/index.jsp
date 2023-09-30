<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>hangman</title>
    <style>
        #categoryDiv {
            font-weight: bold;
            font-size: 2em;
            margin: 30px;
        }
        #imgDiv img {
            width: 450px;
            height: 450px;
            margin: 10px;
        }
        #wordDiv {
            margin-bottom:30px;
            font-weight: bold;
            font-size: 5em;
        }
        #wordDiv span{
            margin: 10px;
        }
        table td input{
            font-weight: bold;
            font-size: 2em;
            font-style: oblique;
            width : 100px;
            border-radius: 5px;
        }
        .wordBtn{
            background-color: lightgray;
        }
        .usedBtn{
            background-color: red;
        }

    </style>
</head>
<body>
<div id="categoryDiv" align="center"></div>
<div id="imgDiv" align="center"><img id="hangmanImg" src="img/0.png"></div>
<div id="wordDiv" align="center"></div>
<div>
    <table align="center">
        <tr>
            <td><input type="button" value="A" class="wordBtn"></td>
            <td><input type="button" value="B" class="wordBtn"></td>
            <td><input type="button" value="C" class="wordBtn"></td>
            <td><input type="button" value="D" class="wordBtn"></td>
            <td><input type="button" value="E" class="wordBtn"></td>
            <td><input type="button" value="F" class="wordBtn"></td>
            <td><input type="button" value="G" class="wordBtn"></td>
            <td><input type="button" value="H" class="wordBtn"></td>
            <td><input type="button" value="I" class="wordBtn"></td>
            <td><input type="button" value="J" class="wordBtn"></td>
            <td><input type="button" value="K" class="wordBtn"></td>
            <td><input type="button" value="L" class="wordBtn"></td>
            <td><input type="button" value="M" class="wordBtn"></td>
        </tr>
        <tr>
            <td><input type="button" value="N" class="wordBtn"></td>
            <td><input type="button" value="O" class="wordBtn"></td>
            <td><input type="button" value="P" class="wordBtn"></td>
            <td><input type="button" value="Q" class="wordBtn"></td>
            <td><input type="button" value="R" class="wordBtn"></td>
            <td><input type="button" value="S" class="wordBtn"></td>
            <td><input type="button" value="T" class="wordBtn"></td>
            <td><input type="button" value="U" class="wordBtn"></td>
            <td><input type="button" value="V" class="wordBtn"></td>
            <td><input type="button" value="W" class="wordBtn"></td>
            <td><input type="button" value="X" class="wordBtn"></td>
            <td><input type="button" value="Y" class="wordBtn"></td>
            <td><input type="button" value="Z" class="wordBtn"></td>
        </tr>
    </table>
</div>
<input type="hidden" id="answer">

<script src="http://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
$(function () {
    let deathCount = 0;

    /*임의의 영어 단어를 가져와 그 단어의 길이 만큼 _를 표시 */
    $.ajax({
        type:'post',
        url:'/hangman/setRandomWord',
        dataType:'text',
        success: function (data) {
            let category = data.split(",")[0];
            let word = data.split(",")[1];
            let wordSpelling = word.split("");
            let result="";

            $('#categoryDiv').text("CATEGORY : " + category);
            $('#answer').val(word);
            $.each(wordSpelling, function (intdex, spelling) {
                result = `<span id="`+ spelling +`">_</span>`;
                $('#wordDiv').append(result);
            });
        },
        error: function (e) {
            console.log(e);
        }
    });


    /*알파벳 버튼을 클릭시 해당 알파벳이 단어에 포함되면 해당 단어에 해당 알파벳을 표시한다.
     틀릴시 deathcount가 1추가되고 8개가 되면 단어를 보여주고 게임에서 진다.
     한번 누른 버튼은 빨간색으로 되며 다시 누를수 없다.*/
    $('.wordBtn').click(function () {
        let spelling = $(this).val();
        $(this).off('click');
        $(this).removeClass('wordBtn').addClass('usedBtn');

        if($('#wordDiv').children('#'+spelling).length > 0) {
            $('#wordDiv').children('#'+spelling).text(spelling);
        } else {
            deathCount+=1;
            $('#hangmanImg').attr('src','./img/'+deathCount+'.png');
        }


        if($('#wordDiv').children().text()==$('#answer').val()){
            $('.wordBtn').off('click');
            setTimeout(function () {
                alert("You Win");
                if(confirm("다시 하시겠습니까?")){
                    location.reload();
                }
            }, 100);
        }

        if (deathCount==8) {
            $('.wordBtn').off('click');
            $('#wordDiv').text($('#answer').val());
            setTimeout(function () {
                alert("You Lose");
                if(confirm("다시 하시겠습니까?")){
                    location.reload();
                }
            }, 100);
        }
    });
});
</script>
</body>
</html>
