package mies

class Documento implements Serializable {
    Proyecto proyecto
    GrupoProcesos grupoProcesos
    String descripcion
    String clave
    String resumen
    String documento

    UnidadEjecutora unidadEjecutora

    static auditable = [ignore: []]
    static mapping = {
        table 'dcmt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dcmt__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dcmt__id'
            proyecto column: 'proy__id'
            grupoProcesos column: 'grpr__id'
            descripcion column: 'dcmtdscr'
            clave column: 'dcmtclve'
            resumen column: 'dcmtrsmn'
            documento column: 'dcmtdcmt'
            unidadEjecutora column: 'unej__id'
        }
    }
    static constraints = {
        proyecto(blank: true, nullable: true, attributes: [mensaje: 'Proyecto'])
        grupoProcesos(blank: true, nullable: true, attributes: [mensaje: 'Grupo de Procesos'])
        descripcion(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Descripción del documento'])
        clave(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Palabras clave'])
        resumen(size: 1..1024, blank: true, nullable: true, attributes: [mensaje: 'Resumen'])
        documento(size: 1..255, blank: true, nullable: true, attributes: [mensaje: 'Ruta del documento'])
        unidadEjecutora(blank: true, nullable: true)
    }

    String toString() {
        return this.descripcion
    }
}