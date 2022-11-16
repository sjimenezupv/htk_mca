using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace ARF_ResultsAnalyzer
{
    /// <summary>
    /// Gets the accuracy statistics for a set of MLF reco files (HTK)
    /// </summary>
    /// <author>Santiago Jiménez-Serrano [sanjiser at upv.es]</author>
    /// <date>2022-11-16</date>
    class Program
    {
        #region - Global Variables -

        public static String[] dirBase = 
        {
            "W:/BIOITACA/TESIS/2022/Tesis_Experimentacion/001_MCA/HTK_MCA_Tesis/linux_scripts/results"
        };

        public static List<MlfRecoFile> TrainResults = new List<MlfRecoFile>();
        public static List<MlfRecoFile> TestResults  = new List<MlfRecoFile>();

        #endregion
        #region - Static functions -

        private static void LoadDir(String dir)
        {
            String[] files = Directory.GetFiles(dir);
            foreach (String  path in files)
            {
                if (path.EndsWith(".mlf"))
                {
                    MlfRecoFile r = new MlfRecoFile(path);
                    if (r.IsTrain)
                    {
                        TrainResults.Add(r);
                    }
                    else
                    {
                        TestResults.Add(r);
                    }
                }
            }
        }

        private static void printList(String header, List<MlfRecoFile> list)
        {
            Console.WriteLine(header);
            Console.Write(MlfRecoFile.Header);
            foreach (MlfRecoFile r in list)
            {
                if (r.NumGaussians > 0)
                {
                    Console.Write(r.ResultsLine);
                }                
            }
        }

        #endregion

        /// <summary>
        /// Main entry point
        /// </summary>
        static void Main(string[] args)
        {
            foreach (String dirBaseAux in dirBase)
            {
                String[] dirs = Directory.GetDirectories(dirBaseAux);
                foreach (String d in dirs)
                {
                    LoadDir(d);
                }
            }

            TrainResults.Sort();
            TestResults.Sort();

            printList("TRAINSET", TrainResults);
            printList("TESTSET",  TestResults);
        }
    }
}
