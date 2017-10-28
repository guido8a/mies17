package mies

class Adquisiciones implements Serializable {
    TipoAdquisicion tipoAdquisicion
    Proyecto proyecto
    TipoProcedencia tipoProcedencia
    String descripcion
    double valor
    double porcentaje
    static auditable = [ignore: []]
    static mapping = {
        table 'adqc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'adqc__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'adqc__id'
            tipoAdquisicion column: 'tpaq__id'
            proyecto column: 'proy__id'
            tipoProcedencia column: 'tppc__id'
            descripcion column: 'adqcdscr'
            valor column: 'adqcvlor'
            porcentaje column: 'adqcpcnt'
        }
    }
    static constraints = {
        tipoAdquisicion(blank: true, nullable: true, attributes: [mensaje: 'Tipo de Adquisición'])
        proyecto(blank: true, nullable: true, attributes: [mensaje: 'Proyecto'])
        tipoProcedencia(blank: true, nullable: true, attributes: [mensaje: 'Tipo de Procedencia'])
        descripcion(size: 1..255, blank: false, attributes: [mensaje: 'Descripción de la adquisición o de lo que se adquiere'])
        valor(blank: true, nullable: true, attributes: [mensaje: 'Valor de lo adquirido'])
        porcentaje(blank: true, nullable: true, attributes: [mensaje: 'Porcentaje de procedencia nacional de lo adquirido'])
    }
}