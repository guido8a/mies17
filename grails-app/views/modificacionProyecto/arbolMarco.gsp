${arbol}
<script type="text/javascript">

    $(".padre").bind("click",function(){
        var band = true
        var check = $(this).attr("checked")
        $.each($(this).parent().find("ul"),function(){
            var ul = $(this)
            if(check=="checked"){
                ul.show("blind")
                var padre = ul.parent().parent()
                if(!padre.hasClass("jstree-open")){
                    padre.addClass("jstree-open")
                    padre.removeClass("jstree-closed")
                }

            }else{
                ul.hide("blind")
                var padre = ul.parent().parent()
                if(!padre.hasClass("jstree-closed")){
                    padre.addClass("jstree-closed")
                    padre.removeClass("jstree-open")
                }

            }
            $.each($(this).find("li"),function(){
                if(check=="checked"){
                    $(this).show()
                    if(!$(this).hasClass("jstree-open")){
                        $(this).addClass("jstree-open")
                        $(this).removeClass("jstree-closed")
                    }
                }else{
                    if(!$(this).hasClass("jstree-closed")){
                        $(this).addClass("jstree-closed")
                        $(this).removeClass("jstree-open")
                    }
                }
                $.each($(this).find(".chk"),function(){
                    if(check=="checked"){
                        $(this).attr("checked",check)
                    }else{
                        $(this).attr("checked",false)
                    }
                });
            });


        });

    });
</script>