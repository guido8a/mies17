package mies

class MenuFlowTagLib {
    static namespace = 'mf'


    def menuSemplades = { attrs ->
        def str = ""

        def x = request.findAll { it.key == 'flowRequestContext' }
        def actual = x["flowRequestContext"].getCurrentState().id

        def items = attrs.items

        def links = (attrs.links == "false" || attrs.links == false || attrs.links == "0" || attrs.links == 0) ? false : true

        str += '<div class="" style="padding: 5px 3px 5px 3px;">' + "\n"

        str += '<ul id="menu">' + "\n"

        items.each {item ->

            def paramsLink = (item.link).clone()

            def clase = ((actual == item.evento) ? "current" : "")

            str += '<li>' + "\n"
            if (links && clase != "current") {
                str += '<a href="' + g.createLink(paramsLink) + '" class="' + clase + '" >' + "\n"
            } else {
                str += '<a href="#" class="noLink ' + clase + '" style="cursor: default;" >' + "\n"
            }
            str += item.text + "\n"
            str += '</a>' + "\n"
            str += '</li>' + "\n"
        }

        str += '</ul>' + "\n"

        str += '</div>' + "\n"

        str += '<script type="text/javascript">'
        str += '$(function() {'
        str += '$(".noLink").click(function () { return false; });'
        str += '});'
        str += '</script>'

        out << str
    }
}
