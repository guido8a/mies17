package mies

class Informe implements Serializable {
    ResponsableProyecto responsableProyecto
    TipoInforme tipo
    Date fecha
    String avance
    String dificultades
    Integer porcentaje=0
    String link
    static auditable=[ignore:[]]
    static mapping = {
        table 'info'
        cache usage:'read-write', include:'non-lazy'
        id column:'info__id'
        id generator:'identity'
        version false
        columns {
            id column:'info__id'
            responsableProyecto column: 'rspy__id'
            tipo column: 'tpif__id'
            fecha column: 'infofcha'
            avance column: 'infoavnc'
            avance type: 'text'
            dificultades column: 'infodifc'
            dificultades type: 'text'
            porcentaje column: 'infopcnt'
            link column: 'infolink'
        }
    }
    static constraints = {
        responsableProyecto( blank:true, nullable:true ,attributes:[mensaje:'Responsable del proyecto'])
        tipo( blank:true, nullable:true ,attributes:[mensaje:'Tipo de informe'])
        fecha( blank:true, nullable:true ,attributes:[mensaje:'Fecha'])
        avance(blank:true, nullable:true ,attributes:[mensaje:'Resumen del avance'])
        dificultades(blank:true, nullable:true ,attributes:[mensaje:'Dificultades'])
        porcentaje( blank:true, nullable:true ,attributes:[mensaje:'Porcentaje acumulado de avance'])
        link(size:1..127, blank:true, nullable:true ,attributes:[mensaje:'Link o enlace al documento real (sistema de trámite)'])
    }
}