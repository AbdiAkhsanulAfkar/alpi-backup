<div class="card-body">
    <div>
        <a href="" class="btn btn-success" data-toggle="modal" data-target="#plotbaru">Plot Kelas Siswa Baru</a>
    </div>
    <div class="table-responsive mt-5">
        <div class="text-center">
            <span class="text-center">Siswa Baru Belum Plot Kelas</span>
            <table class="table table-bordered mt-2">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>NIPD</th>
                        <th>Nama</th>
                        <th>Jurusan</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $no = 1;
                    foreach ($plotsiswabaru as $d) : ?>
                        <tr>

                            <td><?= $no++ ?></td>
                            <td><?= $d->nipd ?></td>
                            <td><?= $d->nama ?></td>
                            <td><?= $d->jurusan ?></td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>
    <div class="modal fade" id="plotbaru" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"> Plot Siswa Baru</h5>
                    <?php if ($this->session->flashdata('success')) { ?>
                        <p><?= $this->session->flashdata('success') ?></p>
                    <?php  } ?>
                    <?php if ($this->session->flashdata('error')) { ?>
                        <p><?= $this->session->flashdata('error') ?></p>
                    <?php  } ?>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <?= form_open_multipart('admin/simpanplotbaru/'); ?>
                <div class="modal-body">
                    <div class="input-group">
                        <select class="form-select" name="nipd" id="nipd">
                            <option value="">Pilih Siswa</option>
                            <?php foreach ($plotsiswabaru as $d) : ?>
                                <option value="<?php echo $d->nipd;?>"><?php echo $d->nama;?></option>
                            <?php endforeach ?>
                        </select>
                    </div>
                    <div class="input-group" >
                        <select class="form-select mt-3" name="kelas" id="kelas">
                            <option value="">Pilih Kelas</option>
                        </select>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                        <button type="submit" name="submit" class="btn btn-success"> <i class="fa fa-pencil"></i> Import Data</button>
                    </div>
                    <?= form_close(); ?>
                </div>
                </form>
            </div>
        </div>
    </div>

</div>
</div>