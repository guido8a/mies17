package mies

class EstudiosTecnicos implements Serializable {
    Proyecto proyecto
    String resumen
    String documento
    Date fecha
    static auditable = [ignore: []]
    static mapping = {
        table 'estc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'estc__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'estc__id'
            proyecto column: 'proy__id'
            resumen column: 'estcrsmn'
            documento column: 'estcdcmt'
            fecha column: 'estcfcha'
        }
    }
    static constraints = {
        proyecto(blank: true, nullable: true, attributes: [mensaje: 'Proyecto'])
        resumen(size: 1..1023, blank: true, nullable: true, attributes: [mensaje: 'Resumen del estudio'])
        documento(size: 1..255, blank: true, nullable: true, attributes: [mensaje: 'Documento (path de acceso al pdf)'])
        fecha(blank: true, nullable: true, attributes: [mensaje: 'Fecha de creación del estudio'])
    }
}