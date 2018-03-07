package mies

class ObjetivoOperativo implements Serializable{

    String codigo
    String descripcion
    ObjetivoEspecifico objetivoEspecifico

    static auditable = [ignore: []]
    static mapping = {
        table 'obop'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'obop__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'obop__id'
            objetivoEspecifico column: 'obep__id'
            codigo column: 'obopcdgo'
            descripcion column: 'obopdscr'
        }
    }

    static constraints = {
        codigo(nullable: false, blank: false)
        descripcion(nullable: false, blank: false)
    }
}
