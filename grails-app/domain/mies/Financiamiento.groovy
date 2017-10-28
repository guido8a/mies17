package mies

class Financiamiento implements Serializable {
    Anio anio
    Fuente fuente
    Proyecto proyecto
    double monto
    static auditable = [ignore: []]
    static mapping = {
        table 'fina'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'fina__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'fina__id'
            anio column: 'anio__id'
            fuente column: 'fnte__id'
            proyecto column: 'proy__id'
            monto column: 'finamnto'
        }
    }
    static constraints = {
        anio(blank: true, nullable: true, attributes: [mensaje: 'Año'])
        fuente(blank: true, nullable: true, attributes: [mensaje: 'Fuente'])
        proyecto(blank: true, nullable: true, attributes: [mensaje: 'Proyecto'])
        monto(blank: false, attributes: [mensaje: 'Monto del financiamiento'])
    }
}