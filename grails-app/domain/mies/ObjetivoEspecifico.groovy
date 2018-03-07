package mies

class ObjetivoEspecifico implements Serializable {

    String codigo
    String descripcion
    ObjetivoInstitucional objetivoInstitucional

    static auditable = [ignore: []]
    static mapping = {
        table 'obep'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'obep__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'obep__id'
            objetivoInstitucional column: 'obei__id'
            codigo column: 'obepcdgo'
            descripcion column: 'obepdscr'
        }
    }

    static constraints = {
        codigo(nullable: false, blank: false)
        descripcion(nullable: false, blank: false)
    }
}
