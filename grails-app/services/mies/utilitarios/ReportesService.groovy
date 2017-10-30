package mies.utilitarios

import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.*;
import java.util.*

class ReportesService {

  static transactional = true
//  def kerberosService

  void mostrarPdf(parametros,nombreArchivoJasper,nombreArchivo,extension,tipoStream,response){
    String fileName = "web-app/reports/"+nombreArchivoJasper+".jasper";
    String outFileName = nombreArchivo+"."+extension;
    HashMap hm=parametros
    def dbConnection=kerberosService.getJavaConnection()
    try {
      JasperPrint print = JasperFillManager.fillReport(fileName, hm,dbConnection);
      OutputStream output
      if(tipoStream=="file")
        output= new FileOutputStream(new File("/home/svt/pdfPrueba.pdf"));
      else{
        output=response.getOutputStream()
        def header = "attachment; filename="+outFileName;
        response.setHeader("Content-Disposition", header);
      }
      switch ( extension ) {
        case "pdf":
          JasperExportManager.exportReportToPdfStream(print, output);
          break
/*
        case "xls":
          ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
          JRXlsExporter exporterXLS = new JRXlsExporter();
          exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT,print);
          exporterXLS.setParameter(JRXlsExporterParameter.OUTPUT_STREAM,byteArrayOutputStream);
          exporterXLS.exportReport();
          output.write(byteArrayOutputStream.toByteArray());
          break
*/
        default:
          JasperExportManager.exportReportToPdfStream(print, output);
          break
      }
    }catch(e){
      println "error en el pdf "+e
    }finally {
      //response.outputStream.flush();
    }
  }
}
