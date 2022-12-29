<?php

class Model_login extends CI_Model
{
    function cek_login($data)
    {
        $query = $this->db->get_where('guru', $data);
        return $query;
    }
    function role($data)
    {
        $query = $this->db->get_where('level', $data);
        return $query;
    }
}
