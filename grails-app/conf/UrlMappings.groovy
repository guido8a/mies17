class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'inicio', accion:'index')
        "500"(controller:"shield",action:"error",exception: RuntimeException)
        "404"(controller:"shield",action:"error404")
        "403"(controller:"shield",action:"ataques")
	}
}
