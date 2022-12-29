<div class="col-md">
            <div class="card">
                <div class="card-header text-center bg-primary text-white">
                    Tambah Data Siswa
                </div>
                <div class="card-body">
                    <?= form_open_multipart('siswa/insert'); ?>
                    <div class="form-group">
                        <label>NISN</label>
                        <input type="text" name="nisn" required class="form-control">
                    </div>
                    <!-- <div class="form-group">
                        <label>Password</label>
                        <input type="text" name="password" required class="form-control">
                    </div> -->
                    <div class="form-group">
                        <label>NAMA</label>
                        <input type="text" name="nama"  required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Jenis Kelamin</label>
                        <input type="text" name="jk"  required class="form-control">
                    </div> 
                    <div class="form-group">
                        <label>Kelas</label>
                        <input type="text" name="kelas"  required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Jurusan</label>
                        <input type="text" name="jurusan" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>No. HP</label>
                        <input type="text" name="no_hp"  required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Alamat</label>
                        <input type="text" name="alamat"  required class="form-control">
                    </div>
                    <button name="submit" class="btn btn-success"> Simpan</button>
                </div>
                <?= form_close(); ?>
            </div>
        </div>