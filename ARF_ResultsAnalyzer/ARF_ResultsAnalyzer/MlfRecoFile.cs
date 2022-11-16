using System;
using System.IO;

namespace ARF_ResultsAnalyzer
{
    /// <summary>
    /// Represents the accuracy statistics for a MLF reco file (HTK)
    /// </summary>
    /// <author>Santiago Jiménez-Serrano [sanjiser at upv.es]</author>
    /// <date>2022-11-16</date>
    class MlfRecoFile : IComparable<MlfRecoFile>
    {
        #region - Constructors -

        public MlfRecoFile(String path)
        {
            Load(path);
        }

        #endregion
        #region - Properties -

        public int VP { get; private set; }
        public int VN { get; private set; }
        public int FP { get; private set; }
        public int FN { get; private set; }
        public int N_SAMPLES   { get { return VP + VN + FP + FN; } }
        public int N_HITS      { get { return VP + VN; } }
        public int N_ERRORS    { get { return FP + FN; } }
        public double Accuracy { get { return (double)N_HITS / (double)N_SAMPLES; } }
        public double G        { get { return Math.Sqrt(Sensitivity * Specificity); } }
        public double Sensitivity
        {
            get
            {
                double vp = VP;
                double fn = FN;
                return vp / (vp + fn);
            }
        }

        public double Specificity
        {
            get
            {
                double vn = VN;
                double fp = FP;
                return vn / (vn + fp);
            }
        }

        public int NumStates    { get; private set; }
        public int HmmIteration { get; private set; }

        public int NumGaussians
        {
            get
            {
                switch (HmmIteration) // This depends on the experimentation performed. Valid for our cinc2017 & caseib2015.
                {
                    case  3: return  1;
                    case  6: return  2;
                    case  9: return  4;
                    case 12: return  8;
                    case 15: return 16;
                    default: return -1;
                }
            }
        }

        public bool IsTrain    { get; private set; }
        public bool IsTest     { get { return !IsTrain; } }
        public String Path     { get; private set; }
        public String FileName { get; private set; }

        public static String Header
        {
            get { return "#ST \t #GS \t ACC \t SEN \t ESP \t G \n"; }
        }

        public String ResultsLine
        {
            get
            {
                return String.Format(
                          "{0} \t {1} \t {2:0.00} \t {3:0.00} \t {4:0.00} \t {5:0.00} \n",
                          NumStates, NumGaussians, Accuracy, Sensitivity, Specificity, G);
            }
        }

        #endregion
        #region - Methods -

        public void Load(String path)
        {
            LoadPathInfo(path);
            LoadInfo(path);
        }

        private void LoadPathInfo(String path)
        {
            this.Path     = path;
            this.FileName = System.IO.Path.GetFileNameWithoutExtension(path);
            this.IsTrain  = this.FileName.Contains(".train.");

            String[] tokens = this.FileName.Split(new char[] { '.' });

            String hmm = tokens[tokens.Length - 2];
            String nSt = tokens[tokens.Length - 1];

            HmmIteration = int.Parse(hmm.Replace("hmm", ""));
            NumStates    = int.Parse(nSt.Replace("numSt", ""));
        }

        private void LoadInfo(string path)
        {
            // Local variables
            bool line1Paciente, line1Control;
            bool line2Paciente, line2Control;

            // Initialize the attributes
            VP = VN = FN = FP = 0;

            // Read the file
            String[] lines = File.ReadAllLines(path);

            // For each 3 lines in the file
            for (int i = 1; i < lines.Length-1; i+=3)
            {
                // Check the lines
                line1Paciente = lines[i].Contains("/PACIENTES.");
                line1Control  = lines[i].Contains("/CONTROLES.");
                line2Paciente = lines[i + 1].Contains(" PACIENTE ");
                line2Control  = lines[i + 1].Contains(" CONTROL ");

                // Avoid errors
                if (line1Paciente == line1Control) { throw new Exception("Error in file (001): " + path); }
                if (line2Paciente == line2Control) { throw new Exception("Error in file (002): " + path); }

                // Avoid noisy samples
                if (lines[i].Contains("1708683"))
                {   
                    continue;
                }
                    

                // Increment the corresponding value
                     if (line1Paciente && line2Paciente) VP++;
                else if (line1Control  && line2Control)  VN++;
                else if (line1Paciente && line2Control)  FN++;
                else if (line1Control  && line2Paciente) FP++;
                else throw new Exception("Error in file (003): " + path);
            }
        }

        public int CompareTo(MlfRecoFile other)
        {
            if (this.NumStates    > other.NumStates)    return +1;
            if (this.NumStates    < other.NumStates)    return -1;
            if (this.NumGaussians > other.NumGaussians) return +1;
            if (this.NumGaussians < other.NumGaussians) return -1;
            return 0;
        }

        #endregion
    }
}
