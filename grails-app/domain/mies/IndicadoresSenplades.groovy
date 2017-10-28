package mies

class IndicadoresSenplades implements Serializable {
    Proyecto proyecto
    double tasaAnalisisFinanciero
    double valorActualNeto
    double tasaInternaDeRetorno
    double tasaAnalisisEconomico
    double valorActualNetoEconomico
    double tasaInternaDeRetornoEconomico
    double costoBeneficio
    String pierdePais
    String impactos
    String metodologia
    String observaciones
    static auditable = [ignore: []]
    static mapping = {
        table 'idsp'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'idsp__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'idsp__id'
            proyecto column: 'proy__id'
            tasaAnalisisFinanciero column: 'idsptsfn'
            valorActualNeto column: 'idspvnfn'
            tasaInternaDeRetorno column: 'idsptrfn'
            tasaAnalisisEconomico column: 'idsptsec'
            valorActualNetoEconomico column: 'idspvnec'
            tasaInternaDeRetornoEconomico column: 'idsptrec'
            costoBeneficio column: 'idspcsbn'
            pierdePais column: 'idspprdd'
            impactos column: 'idspimpt'
            metodologia column: 'idspmeto'
            observaciones column: 'idspobsr'
        }
    }
    static constraints = {
        proyecto(blank: true, nullable: true, attributes: [mensaje: 'Proyecto'])
        tasaAnalisisFinanciero(blank: true, nullable: true, attributes: [mensaje: 'Tasa de Análisis Financiero'])
        valorActualNeto(blank: true, nullable: true, attributes: [mensaje: 'Valor actual neto del análisis financiero'])
        tasaInternaDeRetorno(blank: true, nullable: true, attributes: [mensaje: 'Tasa interna de retorno del análisis financiero'])
        tasaAnalisisEconomico(blank: true, nullable: true, attributes: [mensaje: 'Tasa de análisis económico'])
        valorActualNetoEconomico(blank: true, nullable: true, attributes: [mensaje: 'Valor actual neto análisis económico'])
        tasaInternaDeRetornoEconomico(blank: true, nullable: true, attributes: [mensaje: 'Tasa interna de retorno del análisis económico'])
        costoBeneficio(blank: true, nullable: true, attributes: [mensaje: 'Relación costo beneficio '])
        pierdePais(size: 1..1023, blank: true, nullable: true, attributes: [mensaje: 'Lo que pierde el país si el proyecto no se ejecuta'])
        impactos(size: 1..1023, blank: true, nullable: true, attributes: [mensaje: 'Resultados e impactos esperados del proyecto'])
        metodologia(size: 1..1023, blank: true, nullable: true, attributes: [mensaje: 'Metodología para determinar el retorno del proyecto'])
        observaciones(size: 1..1023, blank: true, nullable: true, attributes: [mensaje: 'Observaciones'])
    }
}