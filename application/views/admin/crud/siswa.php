<div class="card-body">
    <div>
        <a href="<?= base_url('admin/siswa') ?>" class="btn btn-info">Tambah Data Siswa</a>
        <a href="" class="btn btn-success" data-toggle="modal" data-target="#import">Import Data Excel</a>
    </div>
    <div class="table-responsive mt-3">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>No</th>
                    <th>NIPD</th>
                    <th>Nama</th>
                    <th>NISN</th>
                    <th>Jk</th>
                    <!-- <th>Kelas</th> -->
                    <th>jurusan</th>
                    <th>No HP</th>
                    <th>Email</th>
                    <th>Alamat</th>
                    <th>Opsi</th>
                </tr>
            </thead>
            <tbody>
                <?php $no = 1;
                foreach ($siswa as $d) : ?>
                    <tr>

                        <td><?= $no++ ?></td>
                        <td><?= $d->nipd ?></td>
                        <td><?= $d->nama ?></td>
                        <td><?= $d->nisn ?></td>
                        <td><?= $d->jk ?></td>
                        <td><?= $d->jurusan_id ?></td>
                        <td><?= $d->no_hp ?></td>
                        <td><?= $d->email ?></td>
                        <td><?= $d->alamat ?></td>
                        <td>
                            <a class="btn btn-danger" href="<?= base_url('siswa/hapus/' . $d->nipd) ?>">Hapus</a>
                            <a class="btn btn-primary" href="javascript:void(0)" data-toggle="modal" data-target="#editModal<?= $d->nipd ?>">Ubah</a>
                        </td>
                    </tr>
                    <div class="modal fade" id="editModal<?= $d->nipd ?>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Ubah Data Siswa</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <?= form_open('siswa/ubah/' . $d->nipd); ?>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label>NIPD</label>
                                        <input type="text" name="nipd" placeholder="NIPD" required class="form-control" value="<?= $d->nipd ?>">
                                    </div>

                                    <div class="form-group">
                                        <label>NAMA</label>
                                        <input type="text" name="nama" placeholder="Nama" required class="form-control" value="<?= $d->nama ?>">
                                    </div>
                                    <div class="form-group">
                                        <label>NISN</label>
                                        <input type="text" name="nisn" placeholder="NISN" required class="form-control" value="<?= $d->nisn ?>">
                                    </div>
                                    <div class="form-group">
                                        <label>Jenis Kelamin</label>
                                        <input type="text" name="jk" placeholder="Jenis Kelamin" required class="form-control" value="<?= $d->jk ?>">
                                    </div>
                                    <!-- <div class="form-group">
                                        <label>Kelas</label>
                                        <input type="text" name="kelas" placeholder="Kelas" required class="form-control" value="">
                                    </div> -->
                                    <div class="form-group">
                                        <label>Jurusan</label>
                                        <input type="text" name="jurusan" placeholder="Jurusan" required class="form-control" value="<?= $d->jurusan_id ?>">
                                    </div>
                                    <div class="form-group">
                                        <label>No. HP</label>
                                        <input type="text" name="no_hp" placeholder="No. HP" required class="form-control" value="<?= $d->no_hp ?>">
                                    </div>
                                    <div class="form-group">
                                        <label>Email</label>
                                        <input type="text" name="email" placeholder="Email" required class="form-control" value="<?= $d->email ?>">
                                    </div>
                                    <div class="form-group">
                                        <label>Alamat</label>
                                        <input type="text" name="alamat" placeholder="Alamat" required class="form-control" value="<?= $d->alamat ?>">
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                                        <button type="submit" class="btn btn-primary"> <i class="fa fa-pencil"></i> Ubah Data</button>
                                    </div>
                                    <?= form_close(); ?>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <div class="modal fade" id="import" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Import Data Siswa</h5>
                    <?php if($this->session->flashdata('success'))  { ?>
			<p><?=$this->session->flashdata('success')?></p>
		<?php  } ?>
		<?php if($this->session->flashdata('error'))  { ?>
			<p><?=$this->session->flashdata('error')?></p>
		<?php  } ?>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form action="<?= base_url('Import/index') ?>" enctype="multipart/form-data" method="post">
                    <div class="modal-body">
                        <div class="form-group">
                            <input type="file" name="upload_excel" required class="form-control" value="">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                            <button type="submit" name="submit" class="btn btn-success"> <i class="fa fa-pencil"></i> Import Data</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

</div>