function [ R ] = XlsDeleteDefaultSheets( xlsPath )
%XLSDELETEDEFAULTSHEETS Borra las Sheets por defecto de un archivo Excel existente
%
%  [ R ] = XlsDeleteDefaultSheets( xlsPath )
% 
%  Borra las Sheets por defecto de un archivo Excel existente.
%  See: % http://www.mathworks.com/matlabcentral/answers/92449-how-can-i-delete-the-default-sheets-sheet1-sheet2-and-sheet3-in-excel-when-i-use-xlswrite
%
% INPUTS
%    xlsPath: Path al fichero xls (Excel)
% 
% OUTPUTS
%          R: True si todo fue bien. False otherwise.




    %excelFileName = 'Test.xls';
    %excelFilePath = pwd; % Current working directory.
    sheetName = 'Hoja'; % EN: Sheet, DE: Tabelle, etc. (Lang. dependent)

    % Open Excel file.
    objExcel = actxserver('Excel.Application');
    %objExcel.Workbooks.Open(fullfile(excelFilePath, excelFileName)); % Full path is necessary!
    objExcel.Workbooks.Open(xlsPath); % Full path is necessary!

    % Delete sheets.
    try
          % Throws an error if the sheets do not exist.
          objExcel.ActiveWorkbook.Worksheets.Item([sheetName '1']).Delete;
          objExcel.ActiveWorkbook.Worksheets.Item([sheetName '2']).Delete;
          objExcel.ActiveWorkbook.Worksheets.Item([sheetName '3']).Delete;          
    catch
        R = false;
        return;
    end

    % Save, close and clean up.
    objExcel.ActiveWorkbook.Save;
    objExcel.ActiveWorkbook.Close;
    objExcel.Quit;
    objExcel.delete;
    R = true;


end

