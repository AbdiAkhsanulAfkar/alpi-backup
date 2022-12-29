<?php
defined('BASEPATH') or exit('No direct script access allowed');

require 'vendor\autoload.php';

use phpDocumentor\Reflection\PseudoTypes\True_;
use PhpOffice\PhpSpreadsheet\Spreadsheet;

class Import extends CI_Controller
{

    public function index()
    {
        if($_SERVER['REQUEST_METHOD']=='POST'){
            $upload_status =  $this->uploadDoc();
			if($upload_status!=false)
			{
				$inputFileName = 'assets/uploads/imports/'.$upload_status;
				$inputTileType = \PhpOffice\PhpSpreadsheet\IOFactory::identify($inputFileName);
				$reader = \PhpOffice\PhpSpreadsheet\IOFactory::createReader($inputTileType);
				$spreadsheet = $reader->load($inputFileName);
				$sheet = $spreadsheet->getSheet(0);
				$count_Rows = 0;
                
                foreach($sheet->getRowIterator() as $row){
                    $nipd = $spreadsheet->getActiveSheet()->getCell('A'.$row->getRowIndex());
                    $nama = $spreadsheet->getActiveSheet()->getCell('B'.$row->getRowIndex());
                    $nisn = $spreadsheet->getActiveSheet()->getCell('C'.$row->getRowIndex());
                    $password = $spreadsheet->getActiveSheet()->getCell('D'.$row->getRowIndex());
                    $jk = $spreadsheet->getActiveSheet()->getCell('E'.$row->getRowIndex());
                    $jurusan_id = $spreadsheet->getActiveSheet()->getCell('F'.$row->getRowIndex());
                    $no_hp = $spreadsheet->getActiveSheet()->getCell('G'.$row->getRowIndex());
                    $email = $spreadsheet->getActiveSheet()->getCell('H'.$row->getRowIndex());
                    $alamat = $spreadsheet->getActiveSheet()->getCell('I'.$row->getRowIndex());
                    $tempat_lahir = $spreadsheet->getActiveSheet()->getCell('J'.$row->getRowIndex());
                    $tanggal_lahir = $spreadsheet->getActiveSheet()->getCell('K'.$row->getRowIndex());
                    $asal_sekolah = $spreadsheet->getActiveSheet()->getCell('L'.$row->getRowIndex());
                    $data = array(
                        'nipd' => $nipd,
                        'nama' => $nama,
                        'nisn' => $nisn,
                        'password' => $jk,
                        'jk' => $jk,
                        'jurusan_id' => $jurusan_id,
                        'no_hp' => $no_hp,
                        'email' => $email,
                        'alamat' => $alamat,
                        'tempat_lahir' => $tempat_lahir,
                        'tanggal_lahir' => $tanggal_lahir,
                        'asal_sekolah' => $asal_sekolah,
                    );
                    $this->db->insert('siswa', $data);
                    $count_Rows++;
                }
                $this->session->set_flashdata('success','Data terimport');
                redirect('/siswa/admin');


            }else{
                $this->session->set_flashdata('error','Data gagal terimport');
                redirect('/siswa/admin');
            }
        }else{
            $this->load->view('admin/siswa');
        }
    }
        // $this->load->model('ImportModel');
        // $data['import'] = $this->ImportModel->get()->result();
        // $data = array(
        //     'list_data'    => $this->ImportModel->getData()
        // );
        

        function uploadDoc()
        {
            $uploadPath = 'assets/uploads/imports/';
            if(!is_dir($uploadPath))
            {
                mkdir($uploadPath,0777,TRUE); // FOR CREATING DIRECTORY IF ITS NOT EXIST
            }
    
            $config['upload_path']=$uploadPath;
            $config['allowed_types'] = 'csv|xlsx|xls';
            $config['max_size'] = 1000000;
            $this->load->library('upload',$config);
            $this->upload->initialize($config);
            if($this->upload->do_upload('upload_excel'))
            {
                $fileData = $this->upload->data();
                return $fileData['file_name'];
            }
            else
            {
                return false;
            }
        }
    
    }
    
    // function import()
    // {

    //     $path_xlsx = "./xlsx/produk.xlsx";

    //     $reader = new \PhpOffice\PhpSpreadsheet\Reader\Xlsx();
    //     $spreadsheet = $reader->load($path_xlsx);
    //     $d = $spreadsheet->getSheet(0)->toArray();

    //     unset($d[0]);

    //     $datas = array();

    //     foreach ($d as $t) {

    //         $data["title"] = $t[0];
    //         $data["price"] = $t[1];
    //         $data["description"] = $t[2];

    //         array_push($datas, $data);
    //     }

    //     $result = $this->Mdl_product->add_data($datas);

    //     if ($result) {

    //         echo "Data berhasil diimport.";
    //     } else {

    //         echo "Data gagal diimport.";
    //     }
    // }